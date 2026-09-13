-- Read-only VFS traversal. Hashing and inventory formats belong to callers.
local M = {}

local function normalized(path)
  assert(type(path) == 'string' and not path:find('[%z\r\n]'), 'Invalid asset path')
  path = path:gsub('\\', '/'):gsub('/+$', '')
  assert(#path > 0, 'Empty asset path')
  return path
end

function M.create(visitFile, options)
  assert(type(visitFile) == 'function', 'A file visitor is required')
  options = options or {}
  local maxEntries, maxDepth = options.maxEntries or 50000, options.maxDepth or 16
  assert(type(maxEntries) == 'number' and maxEntries >= 1 and maxEntries <= 50000
    and maxEntries == math.floor(maxEntries), 'Invalid asset entry limit')
  assert(type(maxDepth) == 'number' and maxDepth >= 0 and maxDepth <= 16
    and maxDepth == math.floor(maxDepth), 'Invalid asset depth limit')
  local onDirectory = options.onDirectory
  assert(onDirectory == nil or type(onDirectory) == 'function', 'Invalid directory visitor')
  local excluded = {}
  for _, name in ipairs(options.excludeDirectories or {}) do
    assert(type(name) == 'string' and name ~= '' and not name:find('[/\\]'),
      'Invalid excluded directory name')
    excluded[name] = true
  end
  local visited, count = {}, 0
  local function entry()
    count = count + 1
    assert(count <= maxEntries, 'Too many asset entries')
  end
  local function childPath(value, parent)
    local path = normalized(value)
    local prefix = parent .. '/'
    assert(path:sub(1, #prefix) == prefix, 'Asset escaped its parent: ' .. path)
    local name = path:sub(#prefix + 1)
    assert(name ~= '' and name ~= '.' and name ~= '..' and not name:find('/', 1, true),
      'Invalid asset child: ' .. path)
    return path, name
  end
  local function directory(path, relative, context, depth)
    assert(depth <= maxDepth, 'Asset directory nesting is too deep')
    if visited[path] then return end
    entry()
    visited[path] = true
    if onDirectory then onDirectory(path, context) end
    local present = {}
    for _, value in ipairs(ucp.internal.io.files(path .. '/')) do
      local file, name = childPath(value, path)
      if not present[file] then
        entry()
        present[file] = true
        visitFile(file, relative .. name, context)
      end
    end
    for _, value in ipairs(ucp.internal.io.directories(path .. '/')) do
      local child, name = childPath(value, path)
      if not excluded[name] then
        -- Folder handles also list ZIPs as synthetic directories. Traverse a
        -- sibling physical folder when present: it can shadow archive members.
        local folder = not present[child .. '.zip'] or pcall(ucp.internal.io.files, child .. '/')
        if folder then directory(child, relative .. name .. '/', context, depth + 1) end
      end
    end
  end
  return function(path, context)
    path = normalized(ucp.internal.resolveAliasedPath(normalized(path) .. '/'))
    directory(path, '', context, 0)
  end
end

return M
