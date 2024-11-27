local registry = require('overrides.registry')

local overrideFileWith = function(file, newFile)
  file = file:lower()

  newFile = newFile:gsub("/+", "\\")

  log(VERBOSE, "Registering override for: " .. file .. ": " .. newFile)

  registry.FILE_OVERRIDES[file] = newFile
end


return overrideFileWith