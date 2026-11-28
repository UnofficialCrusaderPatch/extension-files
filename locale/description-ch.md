# Files
此扩展名为 files，因为它会拦截游戏执行的文件操作。

其核心功能是拦截特定的 `open` 文件操作，并将其重定向到指定的文件。

许多依赖拦截 `open` 操作的扩展都以本扩展为基础。

## 使用方法
此扩展提供五个函数：
```lua
--[[
覆盖/拦截指定文件的 open 操作。
注意游戏使用 Windows 风格路径，例如 "maps\\Close Encounters.map"

file  string  游戏使用的原始路径
newfile  string  用于替换原文件的新文件路径
--]]
modules.files:overrideFileWith(file, newFile)

--[[
注册一个在每次执行 open 操作时调用的覆盖函数。
适用于不是只加载一次、而是在游戏过程中多次加载的文件。
--]]
modules.files:registerOverrideFunction(func)

--[[
供 maploader 扩展使用，用于设置游戏加载 .amp 和 .sav 文件的参数。
--]]
modules.files:setIterationOption(key, value)

--[[
为游戏设置查找游戏文件的备用位置（仅限 gm、gfx、fx、binks）。
地图应通过 maploader 注册。
--]]
modules.files:registerFileSource(path)

--[[
将一个包含 .map 文件的文件夹添加到游戏的地图列表中。`which` 为 "both"（默认）、"crusader" 或 "extreme"。
可注册多个文件夹，例如每个插件一个。
--]]
modules.files:registerExtraMapDirectory(path, which)

```

## 按日期解锁的地图
额外地图文件夹可包含一个 `availability.json`，按玩家本地时间在指定日期之后才列出对应地图，适用于每日解锁一张地图的地图包。格式见 [README](https://github.com/UnofficialCrusaderPatch/extension-files/blob/main/README.md)。
