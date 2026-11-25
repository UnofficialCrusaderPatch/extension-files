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

---Whether a map named in the availability.json of an extra map directory can be played today,
---decided as the map list decides it. Dated maps whose date has come get their file redirects at
---this call, as when the list is built, so the map can be opened without the list.
---@param self table the files module itself
---@param name string the map name, with or without ".map"
---@param which string|nil "crusader" (default) or "extreme"
---@return table result { available = boolean, from = string|nil } (one value: the framework passes
---on only the first result of a public function). available: false while no copy of the dated
---map can be opened yet; true for a map that is due, or that no availability.json names (also
---when the map doesn't exist). from: "YYYY-MM-DD", the date of the dated copy that opens, or while
---none can, the earliest date one opens; nil when no copy is dated or an undated copy opens
function files:getMapAvailability(name, which)
  local available, from = discovery.getMapAvailability(name, which)
  return { available = available, from = from }
end

return files, {
    public = {
        "overrideFileWith",
        "registerOverrideFunction",
        "setIterationOption",
        'registerFileSource',
        'registerExtraMapDirectory',
        'getMapAvailability',
    }
}
