# Files
Esta extensión se llama «files» porque intercepta las operaciones de archivo realizadas por el juego.

Su función principal es interceptar operaciones `open` específicas para redirigirlas a los archivos elegidos.

Esta extensión sirve de motor para muchas otras que dependen de interceptar la operación `open`.

## Uso
Esta extensión ofrece cinco funciones:
```lua
--[[
Sobrescribe/intercepta la operación open de un archivo concreto.
Ten en cuenta que el juego usa rutas de Windows, como "maps\\Close Encounters.map".

file  string  la ruta original usada por el juego
newfile  string  la ruta al archivo que reemplazará al original
--]]
modules.files:overrideFileWith(file, newFile)

--[[
Registra una función de sobrescritura que se llama cada vez que se ejecuta una operación open.
Útil para archivos que no se cargan una sola vez, sino varias veces durante la partida.
--]]
modules.files:registerOverrideFunction(func)

--[[
Usada por la extensión maploader para definir parámetros de carga de archivos .amp y .sav del juego.
--]]
modules.files:setIterationOption(key, value)

--[[
Configura una ubicación alternativa donde el juego busca archivos (solo gm, gfx, fx, binks).
Los mapas deben registrarse con maploader.
--]]
modules.files:registerFileSource(path)

--[[
Añade una carpeta de archivos .map a las listas de mapas del juego. `which` es "both" (por defecto), "crusader" o "extreme".
Se pueden registrar varias carpetas, por ejemplo una por complemento.
--]]
modules.files:registerExtraMapDirectory(path, which)

```

## Mapas disponibles a partir de una fecha
Una carpeta de mapas adicional puede incluir un archivo `availability.json` que muestra ciertos mapas solo a partir de una fecha determinada, según la hora local del jugador, para paquetes que desbloquean un mapa al día. El formato está en el [README](https://github.com/UnofficialCrusaderPatch/extension-files/blob/main/README.md).
