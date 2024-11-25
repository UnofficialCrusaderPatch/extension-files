local overwriteResource = require('overrides.overwriteResource')

local function setupBinkHook()
  local addressOfBinkOpenRef = core.readInteger(core.AOBScan("68 ? ? ? ? 50 FF ? ? ? ? ? 89 44 BE 50") + 8)
  local addressOfBinkOpen = core.readInteger(addressOfBinkOpenRef)

  local BinkOpen_callingConvention = 2
  local BinkOpen_argCount = 2

  local BinkOpen = core.exposeCode(addressOfBinkOpen, BinkOpen_argCount, BinkOpen_callingConvention)

  local BinkOpen_stub = core.allocateCode({ 0x90, 0x90, 0x90, 0x90, 0xC2, BinkOpen_argCount * 4, 0x00 }) --nops and return 08

  local BinkOpen_hook = function(fileName, flags)
      local luaFileName = core.readString(fileName)

      luaFileName = ucp.internal.resolveAliasedPath(luaFileName)

      local retValue
      local o = overwriteResource(luaFileName)
      if o ~= nil then
          -- core.writeString(ovrsBuffer, o)
          retValue = BinkOpen(ucp.internal.registerString(o), flags)
      else
          retValue = BinkOpen(fileName, flags)
      end

      return retValue
  end

  core.hookCode(BinkOpen_hook, BinkOpen_stub, BinkOpen_argCount, BinkOpen_callingConvention, 5)
  core.writeCode(addressOfBinkOpenRef, { BinkOpen_stub })
end

return setupBinkHook