# Files
Ez a bővítmény azért kapta a „files” nevet, mert elfogja a játék által végzett fájlműveleteket.

Fő funkciója, hogy bizonyos `open` fájlműveleteket elfogjon és tetszőleges fájlokra irányítson át.

Számos, az `open` művelet átirányítására épülő bővítmény alapmotorjaként szolgál.

## Használat
Ez a bővítmény öt függvényt biztosít:
```lua
--[[
Felülírja/elfogja egy adott fájl open műveletét.
A játék Windows stílusú elérési utakat használ, például: "maps\\Close Encounters.map"

file  string  a játék által használt eredeti útvonal
newfile  string  az eredeti fájlt helyettesítő fájl útvonala
--]]
modules.files:overrideFileWith(file, newFile)

--[[
Felülíró függvényt regisztrál, amely minden open műveletnél lefut.
Olyan fájloknál hasznos, amelyeket a játék nem csak egyszer, hanem többször is betölt.
--]]
modules.files:registerOverrideFunction(func)

--[[
A maploader bővítmény használja a játék .amp és .sav fájlbetöltési paramétereinek beállítására.
--]]
modules.files:setIterationOption(key, value)

--[[
Alternatív keresési helyet ad meg a játék fájljaihoz (csak gm, gfx, fx, binks).
A pályákat a maploader segítségével kell regisztrálni.
--]]
modules.files:registerFileSource(path)

--[[
Egy .map fájlokat tartalmazó mappát ad a játék pályalistáihoz. A `which` értéke "both" (alapértelmezett), "crusader" vagy "extreme".
Több mappa is regisztrálható, például bővítményenként egy.
--]]
modules.files:registerExtraMapDirectory(path, which)

```

## Adott dátumtól megjelenő pályák
Egy további pályamappa tartalmazhat egy `availability.json` fájlt, amely a játékos helyi ideje szerint csak egy megadott dátumtól listázza a pályákat, például napi egy pályát megnyitó csomagokhoz. A formátum a [README](https://github.com/UnofficialCrusaderPatch/extension-files/blob/main/README.md) fájlban található.
