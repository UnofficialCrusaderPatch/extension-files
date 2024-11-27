---@type fun(path: string):string[]
local directories = ucp.internal.io.directories

---@type fun(path: string):string[]
local files = ucp.internal.io.files

---@type fun(path: string): string
local resolveAliasedPath = io.resolveAliasedPath

---@type fun(file: string, newfile: string):void
local overrideFileWith = require("overrides.overrideFileWith")


local function registerFiles(fullPath, relativePath)
    for _, file in ipairs(files(fullPath)) do
        local relativeFile = file:sub(fullPath:len() + 1)
        local trigger = relativePath:gsub("/", "\\") .. relativeFile

        log(DEBUG, string.format("Setting trigger: %s for %s", trigger, file))
        overrideFileWith(trigger, file)
    end
end

---@param relativePath string The path to register relative to the game directory
---@return void
local function registerFileSource(relativePath)
    local path = resolveAliasedPath(relativePath)
    path = path:gsub("\\", "/")

    if path:sub(-1) ~= "\\" and path:sub(-1) ~= "/" then
        path = path .. "/"
    end

    for _, subdir in ipairs(directories(path)) do
        log(VERBOSE, subdir)

        local relativeSubPath = subdir:sub(path:len() + 1)
        log(VERBOSE, relativeSubPath)

        if relativeSubPath == "gm/" or relativeSubPath == "gfx/" or relativeSubPath == "fx/" or relativeSubPath == "binks/" then
            log(DEBUG, 'registerFileSource: registering relative path: ' .. relativeSubPath)

            registerFiles(subdir, relativeSubPath)

            for _, subsubdir in ipairs(directories(subdir)) do
                local rsubsubdir = subsubdir:sub(subdir:len() + 1)
                local relativeSubSubPath = relativeSubPath .. rsubsubdir

                log(DEBUG, 'registerFileSource: registering relative nested path: ' .. relativeSubSubPath)

                registerFiles(subsubdir, relativeSubSubPath)
            end
        else
            log(WARNING, 'registerFileSource: ignoring unsupported relative path: ' .. relativeSubPath)
        end
    end
end

return {
    registerFileSource = registerFileSource,
}
