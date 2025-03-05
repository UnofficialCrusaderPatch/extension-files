local overrides = require('overrides')
-- local iteration = require('iteration')
local discovery = require('discovery')

---@module "files"
local files = {
  enable = function(self, config)
    overrides.enable(config)
    discovery.enable(config)
  end,
  disable = function(self, config)
  end,
}



function files:overrideFileWith(file, newFile)
  return overrides.overrideFileWith(file, newFile)
end
function files:registerOverrideFunction(func)
  return overrides.registerOverrideFunction(func)
end
function files:setIterationOption(key, value)
  return discovery.setOption(key, value)
end

---Register an extra file source for game files
---Does not support map files, use registerExtraMapDirectory
---@param relativePath string The path to register relative to the game directory
---@return void
function files:registerFileSource(path)
  return overrides.registerFileSource(path)
end


---Register an extra map directory for Crusader, Crusader Extreme, or both (default)
---@param self table the files module itself
---@param path string The folder containing the maps
---@param which string Either "both", "crusader" or "extreme" indicating which game should load these maps
---@return void
function files:registerExtraMapDirectory(path, which)
  return discovery.registerExtraMapDirectory(path, which)
end

return files, {
    public = {
        "overrideFileWith",
        "registerOverrideFunction",
        "setIterationOption",
        'registerFileSource',
        'registerExtraMapDirectory',
    }
}
