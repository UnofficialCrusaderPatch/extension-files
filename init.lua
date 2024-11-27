local namespace = {}

local overrides = require('overrides')
-- local iteration = require('iteration')
local discovery = require('discovery')

return {
    enable = function(self, config)
        overrides.enable(config)
        discovery.enable(config)
    end,
    disable = function(self, config)
    end,
    overrideFileWith = function(self, file, newFile)
        overrides.overrideFileWith(file, newFile)
    end,
    registerOverrideFunction = function(self, func)
        overrides.registerOverrideFunction(func)
    end,
    setIterationOption = function(self, key, value)
        discovery.setOption(key, value)
    end,

    ---@type fun(self: table, path: string):void
    registerFileSource = function(self, path)
        overrides.registerFileSource(path)
    end,
}, {
    public = {
        "overrideFileWith",
        "registerOverrideFunction",
        "setIterationOption",
        'registerFileSource',
    }
}
