# Files
Diese Erweiterung heißt „files“, weil sie die Dateioperationen des Spiels abfängt.

Eine zentrale Funktion besteht darin, bestimmte `open`-Dateioperationen abzufangen und auf frei gewählte Dateien umzuleiten.

Diese Erweiterung bildet die Grundlage für viele Erweiterungen, die auf das Umleiten von `open`-Aufrufen angewiesen sind.

## Verwendung
Diese Erweiterung stellt fünf Funktionen bereit:
```lua
--[[
Überschreibt/fängt den open-Aufruf für eine bestimmte Datei ab.
Hinweis: Das Spiel verwendet Windows-Pfade, z. B. "maps\\Close Encounters.map".

file  string  der ursprüngliche Pfad, wie ihn das Spiel verwendet
newfile  string  der Pfad zur Datei, die das Original ersetzen soll
--]]
modules.files:overrideFileWith(file, newFile)

--[[
Registriert eine Überschreibungsfunktion, die bei jedem open-Aufruf ausgeführt wird.
Nützlich für Dateien, die nicht nur einmal, sondern im Spielverlauf mehrfach geladen werden.
--]]
modules.files:registerOverrideFunction(func)

--[[
Wird von der Erweiterung maploader verwendet, um Parameter für das Laden von .amp- und .sav-Dateien zu setzen.
--]]
modules.files:setIterationOption(key, value)

--[[
Richtet einen alternativen Suchort für Spieldateien ein (nur gm, gfx, fx, binks).
Karten sollten über den maploader registriert werden.
--]]
modules.files:registerFileSource(path)

--[[
Fügt den Kartenlisten des Spiels einen Ordner mit .map-Dateien hinzu. `which` ist "both" (Standard), "crusader" oder "extreme".
Mehrere Ordner können registriert werden, z. B. einer pro Plugin.
--]]
modules.files:registerExtraMapDirectory(path, which)

```

## Karten, die ab einem bestimmten Datum erscheinen
Ein zusätzlicher Kartenordner kann eine `availability.json` enthalten, die Karten erst ab einem bestimmten Datum in der Ortszeit des Spielers auflistet – für Kartenpakete, die jeden Tag eine Karte freischalten. Das Format steht in der [README](https://github.com/UnofficialCrusaderPatch/extension-files/blob/main/README.md).
