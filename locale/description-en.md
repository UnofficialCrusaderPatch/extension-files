# Files
This extension is named files because it hijacks the file operations that are performed by the game.

A key feature is to provide a method for hijacking specific `open` file operations to direct them to files of choice.

This extension provides the engine of many extensions that rely on hijacking the `open` operation.

## Usage
This extension provides four functions:
```lua
--[[
Override/hijack the open operation for a specific file.
Note that the game uses Windows OS style paths, such as "maps\\Close Encounters.map"

file  string  the original path as used by the game
newfile  string  the path to the file that should override the original
--]]
modules.files:overrideFileWith(file, newFile)

--[[
Register an override function that is called each time an open operation is called.
This is useful for files that are not loaded once, but are rather loaded more often during the game.
--]]
modules.files:registerOverrideFunction(func)

--[[
This function is used by the maploader extension to set parameters for the game's .amp and .sav file loading
--]]
modules.files:setIterationOption(key, value)

--[[
With this function you can set up an alternative location for the game to look for game files (only gm, gfx, fx, binks)
Maps should be registered with the maploader
--]]
modules.files:registerFileSource(path)

```
