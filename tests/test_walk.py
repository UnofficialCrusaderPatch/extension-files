"""Exercise the exported API through UCP's actual public proxy on both Lua engines."""
import os
from pathlib import Path

import pytest
from lupa.lua54 import LuaRuntime as Lua54
from lupa.luajit21 import LuaRuntime as LuaJIT

ROOT = Path(__file__).resolve().parents[1]
FRAMEWORK = Path(os.environ.get('UCP_FRAMEWORK_TEST_ROOT', ROOT.parent / 'UnofficialCrusaderPatch3'))


@pytest.fixture(params=[Lua54, LuaJIT], ids=['lua54', 'luajit'])
def lua(request):
    runtime = request.param(unpack_returned_tuples=True)
    runtime.globals().root = ROOT.as_posix()
    runtime.globals().proxy_path = (FRAMEWORK / 'content/ucp/code/extensions/proxies.lua').as_posix()
    runtime.execute('''
package.path=root..'/?.lua;'..package.path
-- Native override/discovery initialization is unrelated to this read-only API.
package.loaded.overrides={}; package.loaded.discovery={}
local files, exports=dofile(root..'/init.lua')
modules={files=dofile(proxy_path).PublicProxy(files,exports.public)}
listing={['root/']={'root/a','root/pack.zip'},['root/code/']={'root/code/b'}}
children={['root/']={'root/code/','root/pack/','root/.git/'},['root/code/']={}}
local calls=0
ucp={internal={resolveAliasedPath=function(path)
 return path=='alias/' and 'root/' or path
end,io={files=function(path)
 calls=calls+1;return assert(listing[path],'Unlistable: '..path)
end,directories=function(path) return assert(children[path]) end}}}
seen={}
function visitor(path,relative,context) seen[#seen+1]={path,relative,context} end
function callsMade() return calls end
''')
    return runtime


def test_proxy_alias_nested_zip_and_physical_shadow(lua):
    lua.execute('''
local walk=modules.files:createFileWalker(visitor,{excludeDirectories={'.git'}})
assert(type(walk)=='function' and callsMade()==0)
walk('alias/','first'); walk('root','duplicate')
assert(#seen==3 and seen[1][1]=='root/a' and seen[1][2]=='a' and seen[1][3]=='first')
assert(seen[3][1]=='root/code/b' and seen[3][2]=='code/b')
listing['root/pack/']={'root/pack/shadow'};children['root/pack/']={}
seen={};modules.files:createFileWalker(visitor,{excludeDirectories={'.git'}})('root')
assert(#seen==4 and seen[4][1]=='root/pack/shadow')
''')


@pytest.mark.parametrize('child', ['elsewhere/x', 'root/../x', 'root/..', 'root/./x', 'root/a/b', 'root/'])
@pytest.mark.parametrize('kind', ['files', 'directories'])
def test_invalid_children_rejected_before_visit(lua, child, kind):
    lua.globals().bad_child = child
    lua.globals().bad_kind = kind
    lua.execute('''
listing['root/']={};children['root/']={}
if bad_kind=='files' then listing['root/']={bad_child} else children['root/']={bad_child} end
assert(not pcall(modules.files:createFileWalker(visitor),'root'))
assert(#seen==0)
''')


def test_bounds_count_files_and_directories_and_limit_depth(lua):
    lua.execute('''
local ok,reason=pcall(modules.files:createFileWalker(visitor,{maxEntries=2}),'root')
assert(not ok and reason:find('Too many asset entries',1,true) and #seen==1)
seen={}
ok,reason=pcall(modules.files:createFileWalker(visitor,{maxDepth=0}),'root')
assert(not ok and reason:find('nesting is too deep',1,true) and #seen==2)
for _,limit in ipairs({0,-1,50001,1.5,math.huge}) do
 assert(not pcall(function() modules.files:createFileWalker(visitor,{maxEntries=limit}) end))
end
''')


def test_cancellation_and_yield_at_directory_boundary(lua):
    lua.execute('''
local walk=modules.files:createFileWalker(visitor,{onDirectory=function() error('cancel') end})
local ok,reason=pcall(walk,'root');assert(not ok and reason:find('cancel',1,true))
assert(#seen==0 and callsMade()==0)
walk=modules.files:createFileWalker(visitor,{excludeDirectories={'.git'},
 onDirectory=function(path) coroutine.yield(path) end})
local task=coroutine.create(function() walk('root') end)
local resumed,path=coroutine.resume(task)
assert(resumed and path=='root' and #seen==0)
resumed,path=coroutine.resume(task)
assert(resumed and path=='root/code' and #seen==2)
assert(coroutine.resume(task) and coroutine.status(task)=='dead' and #seen==3)
''')


def test_missing_root_errors_and_duplicate_files_are_visited_once(lua):
    lua.execute('''
assert(not pcall(modules.files:createFileWalker(visitor),'missing'))
listing['root/']={'root/a','root/a'};children['root/']={}
modules.files:createFileWalker(visitor)('root');assert(#seen==1)
''')
