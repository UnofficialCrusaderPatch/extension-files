# Read-only file traversal

Files 1.4.0 adds `modules.files:createFileWalker(visitFile, options)`.
It returns `walk(root, context)`, usable through the framework public module proxy.

`visitFile(path, relativePath, context)` receives each file's resolved VFS path,
its path relative to the supplied root, and the caller's optional context value.
The walker resolves aliases and visits each resolved directory once across all
calls to that walker. Create a new walker for each inventory or verification.
If any visitor or listing fails, the error propagates; discard that walker.

Options:

- `maxEntries`: combined visited file/directory limit, 1–50,000; default 50,000.
- `maxDepth`: directory depth limit, 0–16; default 16, with the root at depth 0.
- `onDirectory(path, context)`: optional progress/cancellation callback before listing.
- `excludeDirectories`: directory names to skip, such as `{'.git'}`; default empty.

The walker uses UCP's VFS listing and alias APIs. A nested ZIP is visited as a
file; a synthetic directory for that archive is skipped unless a physical sibling
folder can also be listed. That folder is included because its contents can
shadow archive members. File order follows the framework listing.

This API does not hash files, open archives itself or decide whether an extension
root should be inventoried as a folder or a ZIP. Those policies and inventory
formats remain with the caller. It installs no additional game hooks and does
no work until called. Use it during loading or validation, outside simulation ticks.

```lua
local walk = modules.files:createFileWalker(function(path, relative, inventory)
  inventory[relative] = hashFile(path)
end, {excludeDirectories = {'.git'}})
local inventory = {}
walk('ucp/plugins/example-1.0.0', inventory)
```
