# Files

A bővítmény neve azért „files”, mert elfogja a játék fájlműveleteit. Elsősorban bizonyos `open` hívásokat tud tetszőleges fájlokra átirányítani. Ezzel számos más, fájlmegnyitást módosító bővítmény alapját adja.

## Használat

A bővítmény négy függvényt biztosít:

Egy adott fájl megnyitását írja felül. A játék Windows-útvonalakat használ, például `maps\Close Encounters.map`. A `file` az eredeti játékbeli útvonal, a `newFile` pedig a helyettesítő fájlé.

```lua
modules.files:overrideFileWith(file, newFile)
```

Átirányító függvényt regisztrál, amely minden fájlmegnyitáskor lefut. Olyan fájloknál hasznos, amelyeket a játék többször, nem csupán egyszer tölt be.

```lua
modules.files:registerOverrideFunction(func)
```

A maploader használja a játék `.map` és `.sav` fájljainak betöltési paramétereihez.

```lua
modules.files:setIterationOption(key, value)
```

Másik keresési helyet ad meg a játék fájljaihoz, kizárólag a `gm`, `gfx`, `fx` és `binks` esetén. A térképeket a maploaderen keresztül kell regisztrálni.

```lua
modules.files:registerFileSource(path)
```
