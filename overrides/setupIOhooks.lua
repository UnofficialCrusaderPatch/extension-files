local overwriteResource = require('overrides.overwriteResource')

local function setupIOhooks(bind)
  local _openAddress = bind("55 8B EC 51 6A 00 8D 45 FC")
  local _closeAddress = bind(
      "6A 10 68 ? ? ? ? E8 ? ? ? ? 8B 45 08 83 F8 FE 75 1B E8 ? ? ? ? 83 20 00 E8 ? ? ? ? C7 ? ? ? ? ? 83 C8 FF E9 ? ? ? ? 33 FF 3B C7 7C 08 3B ? ? ? ? ? 72 21 E8 ? ? ? ? 89 38 E8 ? ? ? ? C7 ? ? ? ? ? 57 57 57 57 57 E8 ? ? ? ? 83 C4 14 EB C9 8B C8 C1 F9 05 8D ? ? ? ? ? ? 8B F0 83 E6 1F C1 E6 06 8B 0B 0F ? ? ? ? 83 E1 01 74 BF 50 E8 ? ? ? ? 59 89 7D FC 8B 03 F6 ? ? ? ? 74 0E")
  local _readAddress = bind(
      "6A 10 68 ? ? ? ? E8 ? ? ? ? 8B 45 08 83 F8 FE 75 1B E8 ? ? ? ? 83 20 00 E8 ? ? ? ? C7 ? ? ? ? ? 83 C8 FF E9 ? ? ? ? 33 F6")
  local _writeAddressPre = bind("E8 ? ? ? ? 83 C4 0C 3B C7 75 0F")
  local fopenAddress = bind("6A 40 FF 74 24 0C")
  local fflushAddress = bind("6A 0C 68 ? ? ? ? E8 ? ? ? ? 33 F6 39 75 08")
  local ftellAddress = bind(
      "6A 0C 68 ? ? ? ? E8 ? ? ? ? 33 C0 33 F6 39 75 08 0F 95 C0 3B C6 75 1D E8 ? ? ? ? C7 ? ? ? ? ? 56 56 56 56 56 E8 ? ? ? ? 83 C4 14 83 C8 FF EB 27")
  local fseekAddress = bind(
      "6A 0C 68 ? ? ? ? E8 ? ? ? ? 33 C0 33 F6 39 75 08 0F 95 C0 3B C6 75 1D E8 ? ? ? ? C7 ? ? ? ? ? 56 56 56 56 56 E8 ? ? ? ? 83 C4 14 83 C8 FF EB 3E")
  local fcloseAddress = bind("6A 0C 68 ? ? ? ? E8 ? ? ? ? 83 4D E4 FF")
  local fread_sAddress = bind("6A 0C 68 ? ? ? ? E8 ? ? ? ? 33 F6 89 75 E4 39 75 10")
  local fwriteAddress = bind("6A 0C 68 ? ? ? ? E8 ? ? ? ? 33 F6 39 75 0C")
  local fsopenAddress = bind("6A 0C 68 ? ? ? ? E8 ? ? ? ? 33 DB 89 5D E4 33 C0 8B 7D 08")
  local _flushAllAddress = bind("6A 14 68 ? ? ? ? E8 ? ? ? ? 33 FF 89 7D E4 89 7D DC")
  local _fgetposAddress = bind("57 33 FF 39 7C 24 08")
  local _fsetposAddress = bind("56 33 F6 39 74 24 08")
  local _filenoAddress = bind(
      "8B 44 24 04 56 33 F6 3B C6 75 1D E8 ? ? ? ? 56 56 56 56 56 C7 ? ? ? ? ? E8 ? ? ? ? 83 C4 14 83 C8 FF")
  local _fgetwcAddress = bind("6A 0C 68 ? ? ? ? E8 ? ? ? ? 33 C0 33 F6 39 75 08 0F 95 C0 3B C6 75 1E")
  local _lseekAddressPre = bind("6A 01 6A 00 FF 74 24 0C E8 ? ? ? ?")
  local _writeAddress = core.readInteger(_writeAddressPre + 1) + _writeAddressPre + 5
  local _lseekAddress = core.readInteger(_lseekAddressPre + 9) + _lseekAddressPre + 13
  local crtEntry = "6A 10 68 ? ? ? ? E8 ? ? ? ? 8B 45 08 83 F8 FE 75 1B"
  assert(core.matchesAOB(crtEntry, _writeAddress), "unexpected _write entry")
  assert(core.matchesAOB(crtEntry, _lseekAddress), "unexpected _lseek entry")

  -- _open: 0x005816c3 & Extreme: 0x581b10
  -- core.writeCode(_openAddress, {0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, })
  -- core.writeCode(_openAddress, { 0xE9, core.getRelativeAddress(_openAddress, io.ucrt._open, -5) })

  local _open = core.exposeCode(io.ucrt._open, 3, 0)
  local o_open
  local function _openHook(fileName, mode, perm)
      local luaFileName = core.readString(fileName)
      log(VERBOSE,
          "_open: " ..
          tostring(luaFileName) .. " mode: " .. string.format("%X", mode) .. " perm: " .. string.format("%X", perm))

      luaFileName = ucp.internal.resolveAliasedPath(luaFileName)

      --local retValue = open(fileName, mode, perm)
      local retValue
      local o = overwriteResource(luaFileName)
      if o ~= nil then
          -- log(VERBOSE, "Overriding with: " .. o)
          -- core.writeString(ovrsBuffer, o)
          retValue = io.openFileDescriptor(o, mode, perm)
          -- retValue = _open(ucp.internal.registerString(o), mode, perm)
      else
          -- log(VERBOSE, "Not overriding : " .. luaFileName)
          retValue = _open(fileName, mode, perm)
      end


      -- log(VERBOSE, retValue)

      return retValue
  end

  o_open = core.hookCode(_openHook, _openAddress, 3, 0, 6)

  -- _close: 0x00580f38 & Extreme: 0x581385
  core.writeCode(_closeAddress, { 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, })
  core.writeCode(_closeAddress, { 0xE9, core.getRelativeAddress(_closeAddress, io.ucrt._close, -5) })



  -- _read: 0x005815c6 & Extreme: 0x581a13
  core.writeCode(_readAddress, { 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, })
  core.writeCode(_readAddress, { 0xE9, core.getRelativeAddress(_readAddress, io.ucrt._read, -5) })

  -- _write: 0x00581f6f & Extreme: 0x5823bc
  core.writeCode(_writeAddress, { 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, })
  core.writeCode(_writeAddress, { 0xE9, core.getRelativeAddress(_writeAddress, io.ucrt._write, -5) })


  -- fopen: 0x005804cd & Extreme: 0x58091a
  -- core.writeCode(fopenAddress, {0x90, 0x90, 0x90, 0x90, 0x90, 0x90, })
  -- core.writeCode(fopenAddress, {0xE9, core.getRelativeAddress(fopenAddress, io.ucrt.fopen, -5) })


  local fopen = core.exposeCode(io.ucrt.fopen, 2, 0)
  local o_fopen
  local function fopenHook(fileName, mode)
      local luaFileName = core.readString(fileName)
      log(VERBOSE, "fopen: " .. tostring(luaFileName) .. " mode: " .. tostring(mode))

      luaFileName = ucp.internal.resolveAliasedPath(luaFileName)

      local retValue
      local o = overwriteResource(luaFileName)
      if o ~= nil then
          -- log(2, "Overriding with: " .. o)
          -- core.writeString(ovrsBuffer, o)
          retValue = io.openFilePointer(o, core.readString(mode))
      else
          retValue = fopen(fileName, mode)
      end


      -- log(2, retValue)

      return retValue
  end

  o_fopen = core.hookCode(fopenHook, fopenAddress, 2, 0, 6)


  -- fflush: 0x00583298 & Extreme: 0x5836e8
  core.writeCode(fflushAddress, { 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, })
  core.writeCode(fflushAddress, { 0xE9, core.getRelativeAddress(fflushAddress, io.ucrt.fflush, -5) })


  -- ftell: 0x0058028f & Extreme: 0x5806dc
  core.writeCode(ftellAddress, { 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, })
  core.writeCode(ftellAddress, { 0xE9, core.getRelativeAddress(ftellAddress, io.ucrt.ftell, -5) })

  -- local ftell = core.exposeCode(io.ucrt.ftell, 1, 0)


  -- do pipes CreatePipe actually support seek? No they don't
  -- fseek: 0x00580384 & Extreme: 0x5807d1
  core.writeCode(fseekAddress, { 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, })
  core.writeCode(fseekAddress, { 0xE9, core.getRelativeAddress(fseekAddress, io.ucrt.fseek, -5) })




  -- fclose: 0x0057fcb2 & Extreme: 0x5800ff
  core.writeCode(fcloseAddress, { 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, })
  core.writeCode(fcloseAddress, { 0xE9, core.getRelativeAddress(fcloseAddress, io.ucrt.fclose, -5) })


  -- fread_s: 0x0057ff34 & Extreme: 0x580381
  core.writeCode(fread_sAddress, { 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, })
  core.writeCode(fread_sAddress, { 0xE9, core.getRelativeAddress(fread_sAddress, io.ucrt.fread_s, -5) })

  -- fwrite: 0x0058099b & Extreme: 0x580de8
  core.writeCode(fwriteAddress, { 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, })
  core.writeCode(fwriteAddress, { 0xE9, core.getRelativeAddress(fwriteAddress, io.ucrt.fwrite, -5) })

  -- fsopen: 0x00580409 & Extreme: 0x580856
  core.writeCode(fsopenAddress, { 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, })
  core.writeCode(fsopenAddress, { 0xE9, core.getRelativeAddress(fsopenAddress, io.ucrt._fsopen, -5) })

  -- -- __flush which is the same as fflush?
  -- core.writeCode(0x0058311a, {0x90, 0x90, 0x90, 0x90, 0x90, 0x90, })
  -- core.writeCode(0x0058311a, {0xE9, core.getRelativeAddress(0x0058311a, io.ucrt.fflush, -5) })

  -- flsall which is I assume _flushall
  -- _flushall: 0x005831be & Extreme: 0x58360e
  core.writeCode(_flushAllAddress, { 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, })
  core.writeCode(_flushAllAddress, { 0xE9, core.getRelativeAddress(_flushAllAddress, io.ucrt._flushall, -5) })

  -- _fgetpos: 0x005833f2 & Extreme: 0x583842
  core.writeCode(_fgetposAddress, { 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, })
  core.writeCode(_fgetposAddress, { 0xE9, core.getRelativeAddress(_fgetposAddress, io.ucrt.fgetpos, -5) })

  -- _fsetpos: 0x0058345d & Extreme: 0x5838ad
  core.writeCode(_fsetposAddress, { 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, })
  core.writeCode(_fsetposAddress, { 0xE9, core.getRelativeAddress(_fsetposAddress, io.ucrt.fsetpos, -5) })

  -- _fileno: 0x0058c4cb & Extreme: 0x58c8fb
  core.writeCode(_filenoAddress, { 0x90, 0x90, 0x90, 0x90, 0x90, })
  core.writeCode(_filenoAddress, { 0xE9, core.getRelativeAddress(_filenoAddress, io.ucrt._fileno, -5) })

  -- _fgetwc: 0x00580735 & Extreme: 0x580b82
  core.writeCode(_fgetwcAddress, { 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, })
  core.writeCode(_fgetwcAddress, { 0xE9, core.getRelativeAddress(_fgetwcAddress, io.ucrt.getwc, -5) })

  -- do pipes CreatePipe actually support seek? No they don't
  -- _lseek: 0x0058277e & Extreme: 0x582b4b
  core.writeCode(_lseekAddress, { 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, })
  core.writeCode(_lseekAddress, { 0xE9, core.getRelativeAddress(_lseekAddress, io.ucrt._lseek, -5) })
end

return setupIOhooks