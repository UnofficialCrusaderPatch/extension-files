local overwriteResource = require('overrides.overwriteResource')


local function setupMilesHook()
    local addressOfAILOpenStreamRef = core.readInteger(core.AOBScan("8B 54 24 14 8B 46 04") + 13)
    local addressOfAILOpenStream = core.readInteger(addressOfAILOpenStreamRef)


    local AIL_open_stream_argCount = 3
    local AIL_open_stream_callingConvention = 2

    local AIL_open_stream = core.exposeCode(addressOfAILOpenStream, AIL_open_stream_argCount,
        AIL_open_stream_callingConvention)


    local AIL_open_stream_stub = core.allocateCode({ 0x90, 0x90, 0x90, 0x90, 0xC2, AIL_open_stream_argCount * 4, 0x00 }) --nops and return 0C

    local AIL_open_stream_hook = function(dig, fileName, stream_mem)
        local luaFileName = core.readString(fileName)

        luaFileName = ucp.internal.resolveAliasedPath(luaFileName)

        local retValue
        local o = overwriteResource(luaFileName)
        if o ~= nil then
            retValue = AIL_open_stream(dig, ucp.internal.registerString(o), stream_mem)
        else
            retValue = AIL_open_stream(dig, fileName, stream_mem)
        end

        return retValue
    end

    core.hookCode(AIL_open_stream_hook, AIL_open_stream_stub, AIL_open_stream_argCount, AIL_open_stream_callingConvention,
        5)
    core.writeCode(addressOfAILOpenStreamRef, { AIL_open_stream_stub })


    local addressOfAILFileReadRef = core.readInteger(core.AOBScan('57 8B 7C 24 0C 6A 00 57 FF ? ? ? ? ?') + 10)
    local addressOfAILFileRead = core.readInteger(addressOfAILFileReadRef)

    local AIL_file_read_argCount = 2
    local AIL_file_read_callingConvention = 2

    local AIL_file_read = core.exposeCode(addressOfAILFileRead, AIL_file_read_argCount, AIL_file_read_callingConvention)

    local AIL_file_read_stub = core.allocateCode({ 0x90, 0x90, 0x90, 0x90, 0xC2, AIL_file_read_argCount * 4, 0x00 })

    local AIL_file_read_hook = function(fileName, dest)
        local luaFileName = core.readString(fileName)

        luaFileName = ucp.internal.resolveAliasedPath(luaFileName)

        local retValue
        local o = overwriteResource(luaFileName)
        if o ~= nil then
            retValue = AIL_file_read(ucp.internal.registerString(o), dest)
        else
            retValue = AIL_file_read(fileName, dest)
        end

        return retValue
    end

    core.hookCode(AIL_file_read_hook, AIL_file_read_stub, AIL_file_read_argCount, AIL_file_read_callingConvention, 5)
    core.writeCode(addressOfAILFileReadRef, { AIL_file_read_stub })


    local addressOfAILFileSizeRef = core.readInteger(core.AOBScan("8B ? ? ? ? ? 57 89 ? ? ? ? ? ? FF ? ? ? ? ?") + 16)
    local addressOfAILFileSize = core.readInteger(addressOfAILFileSizeRef)

    local AIL_file_size_argCount = 1
    local AIL_file_size_callingConvention = 2

    local AIL_file_size = core.exposeCode(addressOfAILFileSize, AIL_file_size_argCount, AIL_file_size_callingConvention)

    local AIL_file_size_stub = core.allocateCode({ 0x90, 0x90, 0x90, 0x90, 0xC2, AIL_file_size_argCount * 4, 0x00 })

    local AIL_file_size_hook = function(fileName)
        local luaFileName = core.readString(fileName)

        luaFileName = ucp.internal.resolveAliasedPath(luaFileName)

        local retValue
        local o = overwriteResource(luaFileName)
        if o ~= nil then
            retValue = AIL_file_size(ucp.internal.registerString(o))
        else
            retValue = AIL_file_size(fileName)
        end

        return retValue
    end

    core.hookCode(AIL_file_size_hook, AIL_file_size_stub, AIL_file_size_argCount, AIL_file_size_callingConvention, 5)
    core.writeCode(addressOfAILFileSizeRef, { AIL_file_size_stub })
end

return setupMilesHook
