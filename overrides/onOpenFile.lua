local registry = require("overrides.registry")


local function onOpenFile(file)

  local override = nil

  for k, func in pairs(registry.FILE_OVERRIDE_FUNCTIONS) do
    override = func(file)
    if override ~= nil then
      return override
    end
  end

  file = file:lower()

  override = registry.FILE_OVERRIDES[file]
  if override ~= nil then
    return override
  end

  return nil
end

return onOpenFile