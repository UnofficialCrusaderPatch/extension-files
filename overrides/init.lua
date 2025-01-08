local setupIOhooks = require('overrides.setupIOhooks')

local setupBinkHook = require('overrides.setupBinkHook')

local setupMilesHook = require("overrides.setupMilesHook")

local sources = require('overrides.sources')

return {
    enable = function(config)
        --[[
          Enlarge the heap memory set up for gm1 file parsing.
          Complex gm1 images that are hard to compress can build up to
          reach the vanilla memory limit.
        --]]
        -- original value:   68100000
        -- new value:       100000000
        local ptr_TextureRenderingCoreImageDataBufferSize = core.AOBScan("6A 00 68 ? ? ? ? 68 ? ? ? ? B9 ? ? ? ? E8 ? ? ? ? 68 ? ? ? ?") + 8
        if core.readInteger(ptr_TextureRenderingCoreImageDataBufferSize) == 68100000 then
          core.writeCode(ptr_TextureRenderingCoreImageDataBufferSize, core.itob(100000000))
        end
        
        setupIOhooks()

        setupBinkHook()

        setupMilesHook()
    end,

    overrideFileWith = require('overrides.overrideFileWith'),

    registerOverrideFunction = require("overrides.registerOverrideFunction"),

    ---@type fun(path: string):void
    registerFileSource = sources.registerFileSource,
}
