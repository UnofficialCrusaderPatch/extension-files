# Files

Die Erweiterung heißt „files“, weil sie die Dateioperationen des Spiels abfängt. Insbesondere kann sie bestimmte `open`-Aufrufe auf frei gewählte Dateien umleiten. Damit bildet sie die Grundlage vieler anderer Erweiterungen, die das Öffnen von Dateien beeinflussen.

## Verwendung

Die Erweiterung stellt vier Funktionen bereit:

Überschreibt den Öffnungsvorgang für eine bestimmte Datei. Das Spiel verwendet Windows-Pfade wie `maps\Close Encounters.map`. `file` ist der ursprüngliche Spielpfad, `newFile` der Pfad zur Ersatzdatei.

```lua
modules.files:overrideFileWith(file, newFile)
```

Registriert eine Umleitungsfunktion, die bei jedem Öffnungsvorgang aufgerufen wird. Das ist für Dateien nützlich, die während des Spiels wiederholt statt nur einmal geladen werden.

```lua
modules.files:registerOverrideFunction(func)
```

Wird von maploader verwendet, um Parameter zum Laden der `.map`- und `.sav`-Dateien des Spiels zu setzen.

```lua
modules.files:setIterationOption(key, value)
```

Legt einen alternativen Suchort für Spieldateien fest, ausschließlich für `gm`, `gfx`, `fx` und `binks`. Karten sollten über maploader registriert werden.

```lua
modules.files:registerFileSource(path)
```
