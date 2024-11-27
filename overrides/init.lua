local setupIOhooks = require('overrides.setupIOhooks')

local setupBinkHook = require('overrides.setupBinkHook')

local setupMilesHook = require("overrides.setupMilesHook")

local sources = require('overrides.sources')

return {
    enable = function(config)
        setupIOhooks()

        setupBinkHook()

        setupMilesHook()
    end,

    overrideFileWith = require('overrides.overrideFileWith'),

    registerOverrideFunction = require("overrides.registerOverrideFunction"),

    ---@type fun(path: string):void
    registerFileSource = sources.registerFileSource,
}
