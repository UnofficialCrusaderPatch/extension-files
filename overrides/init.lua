local setupIOhooks = require('overrides.setupIOhooks')

local setupBinkHook = require('overrides.setupBinkHook')

local setupMilesHook = require("overrides.setupMilesHook")

local sources = require('overrides.sources')

local function bind(pattern)
    local site, reason = core.AOBScanUnique(pattern)
    assert(site, tostring(reason) .. " (" .. pattern .. ")")
    return site
end

local function install(feature, fn)
    local ok, reason = pcall(fn, bind)
    if not ok then log(ERROR, "Files " .. feature .. " is off: " .. tostring(reason)) end
end

return {
    enable = function(config)
        install("GM image buffer expansion", function()
            local address = bind("6A 00 68 ? ? ? ? 68 ? ? ? ? B9 ? ? ? ? E8 ? ? ? ? 68 ? ? ? ?") + 8
            if core.readInteger(address) == 68100000 then
                core.writeCode(address, core.itob(100000000))
            end
        end)
        install("file I/O redirection", setupIOhooks)
        install("Bink file redirection", setupBinkHook)
        install("Miles file redirection", setupMilesHook)
    end,

    overrideFileWith = require('overrides.overrideFileWith'),

    registerOverrideFunction = require("overrides.registerOverrideFunction"),

    ---@type fun(path: string):void
    registerFileSource = sources.registerFileSource,
}
