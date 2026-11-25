# Files

UCP3 module that redirects the game's file operations; see `locale/description-en.md` for its
functions.

## Maps that appear from a date on
An extra map folder (from `registerExtraMapDirectory` or the maploader's extra map directory) can hold a file named `availability.json`. Every map named in it is listed in the game only from its date on, in the player's local time. Maps that are not named are listed as usual. This is meant for map packs that open one map per day, such as an advent calendar.

```json
{
  "format": 1,
  "maps": {
    "Door01": "2026-12-01",
    "Door02": "2026-12-02"
  }
}
```

- `"format": 1` is optional; other formats are not read. The file must be valid JSON of at most 32 KB.
- Map names are the file names, with or without `.map`, compared without ASCII letter case. The game reads file names in the Windows code page; a name with letters such as `ü` is also matched in its Latin-1 form, which fits Western European Windows. Names with letters outside Latin-1 can't be matched, so those maps are listed from the start. ASCII file names are safest.
- The framework JSON decoder may accept malformed escapes and keeps the last value for identical keys. JSON null values are treated as absent. A decoder error or invalid schedule shape logs one warning and leaves all maps in the folder listed. Missing files and invalid dates leave the affected maps listed. Different spellings of the same map keep the earlier date. Only folders inside the game folder can have an `availability.json`.
- The game checks the dates whenever it builds its map list. A map whose day starts while the game is running appears the next time the list is built.
- Until its date, a dated map also doesn't replace a map with the same name, for example one in the game's own `maps` folder. From its date on it does, like any other extra map. When several folders have a map of that name, which one opens depends on the order in which they are registered and become available, so give dated maps names of their own.
- Saved games are not affected.
- Other modules can ask whether a map can be played today with `modules.files:getMapAvailability(name, game)`, `game` being `"crusader"` (the default) or `"extreme"`. It decides as the map list does and returns a table `{ available = ..., from = ... }`:
  - `available = false` and `from` the earliest date one of its copies opens (`"2026-12-05"`) while no copy of a dated map can be opened;
  - `available = true` and `from` the date of the dated copy that opens;
  - `available = true` and no `from` when an undated copy in an extra map folder opens, or when no `availability.json` names the map. It doesn't check that the map exists, and a same-named map in the game's own folders isn't looked at.

  Dated maps whose date has come get their file redirects at this call, as when the list is built, so a module can open the map without the list having been shown. Custom Skirmish Trails uses this for its scenario missions.
- Map authors can preview a schedule without changing the system clock: set `map-availability-date` to a date such as `2026-12-05` in `ucp-config.yml`, in the files or the maploader configuration (the maploader's value wins when both are set). That date then counts as today. The option has no launcher control.
