local onOpenFile = require("overrides.onOpenFile")

local function overwriteResource(filepath)
  log(VERBOSE, "Game opened file: " .. tostring(filepath))

  local override = onOpenFile(filepath)

  if override == nil then
      log(VERBOSE, "No override found for: '" .. tostring(filepath) .. "'")
  else
      override = ucp.internal.resolveAliasedPath(override)
      log(VERBOSE, "File '" .. tostring(filepath) .. "' overriden with: " .. tostring(override))
  end

  return override
end

return overwriteResource