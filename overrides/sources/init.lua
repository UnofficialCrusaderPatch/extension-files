---@type fun(path: string):string[]
local directories = ucp.internal.io.directories

---@type fun(path: string):string[]
local files = ucp.internal.io.files

---@type fun(path: string): string
local resolveAliasedPath = io.resolveAliasedPath

---@type fun(file: string, newfile: string):void
local overrideFileWith = require("overrides.overrideFileWith")

---@param path string The path to register
---@return void
local function registerFileSource(path)
    local path = resolveAliasedPath(path)
    path = path:gsub("\\", "/")

    if path:sub(-1) ~= "\\" and path:sub(-1) ~= "/" then
        path = path .. "/"
    end

    for index, subdir in ipairs(directories(path)) do
        log(INFO, subdir)

        local relativePath = subdir:sub(path:len() + 1)
        log(INFO, relativePath)

        if relativePath == "gm/" then
            log(INFO, 'known relative path: ' .. relativePath)

            for _, file in ipairs(files(subdir)) do
                log(INFO, file)
                local relativeFile = file:sub(subdir:len() + 1)
                log(INFO, relativeFile)

                local trigger = relativePath:gsub("/", "\\") .. relativeFile

                log(INFO, string.format("Setting trigger: %s for %s", trigger, file))
                overrideFileWith(trigger, file)
            end
        end
    end
end

return {
  registerFileSource = registerFileSource,
}