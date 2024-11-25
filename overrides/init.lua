local setupIOhooks = require('overrides.setupIOhooks')

local setupBinkHook = require('overrides.setupBinkHook')

local setupMilesHook = require("overrides.setupMilesHook")

local registry = require('overrides.registry')

return {
    enable = function(config)
        setupIOhooks()

        setupBinkHook()

        setupMilesHook()
    end,

    overrideFileWith = function(file, newFile)
        file = file:lower()

        newFile = newFile:gsub("/+", "\\")

        log(VERBOSE, "Registering override for: " .. file .. ": " .. newFile)

        registry.FILE_OVERRIDES[file] = newFile
    end,

    registerOverrideFunction = function(func)
        table.insert(registry.FILE_OVERRIDE_FUNCTIONS, func)
    end
}
