local registry = require('overrides.registry')

local overrideFileWith = function(file, newFile)
  log(VERBOSE, string.format("overrideFileWith: Registering override for: %s: %s", file, newFile))

  file = file:lower()

  newFile = newFile:gsub("/+", "\\")

  log(VERBOSE, file .. ": " .. newFile)

  registry.FILE_OVERRIDES[file] = newFile
end


return overrideFileWith