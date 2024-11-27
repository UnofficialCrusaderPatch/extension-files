local registry = require('overrides.registry')

local function registerOverrideFunction(func)
  table.insert(registry.FILE_OVERRIDE_FUNCTIONS, func)
end

return registerOverrideFunction