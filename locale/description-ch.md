# Files

此扩展名为“files”，因为它会拦截游戏的文件操作。主要功能之一是将特定的 `open` 调用重定向到您选择的文件。许多需要改变文件打开行为的扩展都以它为基础。

## 使用方法

此扩展提供四个函数：

覆盖特定文件的打开操作。游戏使用 Windows 风格路径，例如 `maps\Close Encounters.map`。`file` 是游戏原本使用的路径，`newFile` 是替换文件的路径。

```lua
modules.files:overrideFileWith(file, newFile)
```

注册一个每次打开文件时都会调用的重定向函数。适用于在游戏中反复加载，而非只加载一次的文件。

```lua
modules.files:registerOverrideFunction(func)
```

由 maploader 用于设置游戏 `.map` 和 `.sav` 文件的加载参数。

```lua
modules.files:setIterationOption(key, value)
```

为游戏文件指定其他搜索位置，仅支持 `gm`、`gfx`、`fx` 和 `binks`。地图应通过 maploader 注册。

```lua
modules.files:registerFileSource(path)
```
