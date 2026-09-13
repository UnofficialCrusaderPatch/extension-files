# Files

La extensión se llama «files» porque intercepta las operaciones de archivos del juego. En particular, permite redirigir determinadas llamadas `open` a archivos elegidos por ti. Proporciona así la base para muchas otras extensiones que modifican la apertura de archivos.

## Uso

La extensión proporciona cuatro funciones:

Sustituye la apertura de un archivo concreto. El juego utiliza rutas de Windows, como `maps\Close Encounters.map`. `file` es la ruta original que usa el juego y `newFile` la del archivo que la sustituye.

```lua
modules.files:overrideFileWith(file, newFile)
```

Registra una función de redirección que se llama cada vez que se abre un archivo. Es útil para archivos que se cargan repetidamente durante la partida, en lugar de una sola vez.

```lua
modules.files:registerOverrideFunction(func)
```

maploader utiliza esta función para configurar la carga de los archivos `.map` y `.sav` del juego.

```lua
modules.files:setIterationOption(key, value)
```

Establece otra ubicación donde buscar archivos del juego, únicamente para `gm`, `gfx`, `fx` y `binks`. Los mapas deben registrarse con maploader.

```lua
modules.files:registerFileSource(path)
```
