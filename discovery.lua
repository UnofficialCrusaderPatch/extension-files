local overrideRegistry = require('overrides.registry')

local DISABLE_GAME_DIR_MAPS = false
local DISABLE_USER_DIR_MAPS = false
local DISABLE_USER_DIR_SAVS = false
local DISABLE_GAME_DIR_MAPS_EXTREME = false
local DISABLE_USER_DIR_MAPS_EXTREME = false
local DISABLE_USER_DIR_SAVS_EXTREME = false

local EXTRA_DIRS = {}

--[[
Dated map availability.

An extra map directory may contain a file named availability.json:

  {
    "format": 1,
    "maps": {
      "Door01": "2026-12-01",
      "Door02": "2026-12-02"
    }
  }

A map named in "maps" (with or without ".map") is listed by the game only from that date on, in
the player's local time, and its file replaces a same-named map only from then on. Maps that are
not named are listed as before. A missing file leaves maps listed. A decode error or an invalid schedule shape leaves all
maps in the folder listed with a warning, and invalid entries leave their own maps listed.

Map names are compared exactly, apart from ASCII letter case and the ".map" ending. The game
reads file names in the Windows code page; a name written in UTF-8 in the file is also tried in
its Latin-1 form, so "Türchen01" matches on Western European Windows. Names with letters outside
Latin-1 can't be matched and are listed.

The option "map-availability-date" ("YYYY-MM-DD") makes that date count as today, so map
authors and testers can preview a schedule without changing the system clock.

The date is checked each time the game builds its map list, so a map whose date arrives while
the game runs appears, and can be opened, the next time the list is built.
--]]
local AVAILABILITY_FILE_NAME = "availability.json"

-- a schedule for hundreds of maps fits easily; larger files are not read
local AVAILABILITY_MAX_BYTES = 32 * 1024

---Per FindFirstFile pattern of an extra directory (lower case): name key -> yyyymmdd
---@type table<string, table<string, number>>
local AVAILABLE_FROM = {}

---Per FindFirstFile pattern (lower case) and game ("crusader", "extreme"): dated maps whose
---file redirect is registered once their date has come: list of { trigger, path, from, registered }
---@type table<string, table<string, table>>
local DATED_MAPS = {}

---yyyymmdd that counts as today instead of the system date, or nil
---@type number|nil
local TODAY_OVERRIDE = nil

local DAYS_IN_MONTH = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }

local function isLeapYear(y)
    return (y % 4 == 0 and y % 100 ~= 0) or (y % 400 == 0)
end

---Parses "YYYY-MM-DD" (a real calendar date) into yyyymmdd, or returns nil
local function parseDate(value)
    if type(value) ~= "string" then return nil end
    local y, m, d = value:match("^(%d%d%d%d)%-(%d%d)%-(%d%d)$")
    if y == nil then return nil end
    y, m, d = tonumber(y), tonumber(m), tonumber(d)
    if y < 1 or m < 1 or m > 12 or d < 1 then return nil end
    local days = DAYS_IN_MONTH[m]
    if m == 2 and isLeapYear(y) then days = 29 end
    if d > days then return nil end
    return y * 10000 + m * 100 + d
end

---Today as yyyymmdd, or nil when the system date can't be read
local function today()
    if TODAY_OVERRIDE ~= nil then return TODAY_OVERRIDE end
    if os == nil or os.date == nil then return nil end
    local ok, now = pcall(os.date, "*t")
    if not ok or type(now) ~= "table" then return nil end
    return now.year * 10000 + now.month * 100 + now.day
end

---True when a map dated `from` is available on `now` (an unknown today counts as available)
local function isAvailable(from, now)
    return from == nil or now == nil or from <= now
end

local function asciiLower(text)
    return (text:gsub("[A-Z]", string.lower))
end

---Comparison key of a file name as the game or the file system gives it
local function fileKey(name)
    local key = asciiLower(name)
    if key:sub(-4) == ".map" then key = key:sub(1, -5) end
    return key
end

---Comparison keys of a name from availability.json (UTF-8): the name itself and, when it has
---letters outside ASCII that all fit Latin-1, its Latin-1 form. The second value is true when
---the name has letters outside Latin-1.
local function scheduleKeys(name)
    local keys = { fileKey(name) }
    if utf8 == nil or not name:find("[\128-\255]") or utf8.len(name) == nil then
        return keys, false -- ASCII, or not UTF-8 (then the bytes are compared as they are)
    end
    local bytes = {}
    for _, codepoint in utf8.codes(name) do
        if codepoint > 255 then return keys, true end
        bytes[#bytes + 1] = string.char(codepoint)
    end
    keys[#keys + 1] = fileKey(table.concat(bytes))
    return keys, false
end

local availabilityJson = json:new({ strictTypes = true })
local jsonObject = getmetatable(availabilityJson:newObject())

---The folder of a registered directory, which may end in "\*.map"
local function folderOf(dir)
    return (dir:gsub("[/\\]%*%.[Mm][Aa][Pp]$", ""):gsub("[/\\]+$", ""))
end

---Reads the availability.json of an extra map directory.
---@param dir string the directory as registered (without "\*.map")
---@return table<string, number>|nil name key -> yyyymmdd, nil without a usable file
local function readAvailability(dir)
    local path = dir .. "/" .. AVAILABILITY_FILE_NAME

    -- The framework's io.open raises an error for paths outside the game folder and for
    -- folders of extensions that aren't installed; such folders simply have no schedule.
    local opened, handle = pcall(io.open, path, "rb")
    if not opened or handle == nil then
        log(VERBOSE, string.format("readAvailability: no readable availability file at %s", path))
        return nil
    end
    local read, text = pcall(function() return handle:read(AVAILABILITY_MAX_BYTES + 1) end)
    pcall(function() handle:close() end)
    if not read then
        log(WARNING, string.format("%s cannot be read (%s); every map in this folder is listed", path, tostring(text)))
        return nil
    end
    text = text or ""
    if #text > AVAILABILITY_MAX_BYTES then
        log(WARNING, string.format("%s is larger than %d bytes; every map in this folder is listed",
            path, AVAILABILITY_MAX_BYTES))
        return nil
    end
    if text:sub(1, 3) == "\239\187\191" then
        text = text:sub(4) -- UTF-8 byte order mark
    end

    local decoded, data, decodeError = pcall(availabilityJson.decode, availabilityJson, text)
    if not decoded or decodeError ~= nil then
        log(WARNING, string.format("%s is not valid JSON (%s); every map in this folder is listed",
            path, tostring(decodeError or data)))
        return nil
    end
    if getmetatable(data) ~= jsonObject then
        log(WARNING, string.format("%s must contain a JSON object; every map in this folder is listed", path))
        return nil
    end
    if data.format ~= nil and data.format ~= 1 then
        log(WARNING, string.format("%s: unknown format %s; every map in this folder is listed", path, tostring(data.format)))
        return nil
    end
    if getmetatable(data.maps) ~= jsonObject then
        log(WARNING, string.format("%s has no \"maps\" object; every map in this folder is listed", path))
        return nil
    end

    local result = {}
    local count = 0
    for name, date in pairs(data.maps) do
        local from = parseDate(date)
        local keys, wide = scheduleKeys(name)
        if keys[1] == "" or from == nil then
            log(WARNING, string.format("%s: entry %s = %s ignored (expected a map name and a date \"YYYY-MM-DD\"); the map is listed",
                path, tostring(name), tostring(date)))
        else
            if wide then
                log(WARNING, string.format("%s: %s has letters the game can't match in file names; the map may be listed early",
                    path, tostring(name)))
            end
            if result[keys[1]] == nil then
                count = count + 1
            else
                log(WARNING, string.format("%s: %s is named twice; the earlier date counts", path, tostring(name)))
            end
            for _, key in ipairs(keys) do
                result[key] = math.min(result[key] or from, from)
            end
        end
    end
    log(INFO, string.format("%s: %d maps with a date", path, count))
    return result
end

---Reads the schedule of an extra directory and remembers it under its FindFirstFile pattern,
---replacing what an earlier registration of the same directory left.
---@return table<string, number>|nil the dated maps of the directory
---@param games table<string, boolean> the games this registration is for ({crusader = true} ...)
local function registerAvailability(fnfDir, dir, games)
    local dated = readAvailability(dir)
    local key = fnfDir:lower()
    AVAILABLE_FROM[key] = dated
    DATED_MAPS[key] = DATED_MAPS[key] or {}
    for game in pairs(games) do
        DATED_MAPS[key][game] = {}
    end
    return dated
end

---Registers the file redirects of the dated maps of `pattern` whose date has come
local function activateDatedMaps(pattern, now)
    local lists = DATED_MAPS[pattern:lower()]
    if lists == nil then return end
    for _, list in pairs(lists) do
        for _, entry in ipairs(list) do
            if not entry.registered and isAvailable(entry.from, now) then
                modules.files:overrideFileWith(entry.trigger, entry.path)
                entry.registered = true
            end
        end
    end
end

local function formatDate(value)
    return string.format("%04d-%02d-%02d", value // 10000, (value // 100) % 100, value % 100)
end

---Whether a map named in an availability.json can be played today, decided as the map list
---decides it: the extra folders' dated maps whose date has come get their redirects, folder by
---folder in the list's order, and the map can be played when a redirect for its name exists.
---@param name string the map name, with or without ".map"
---@param game string|nil "crusader" (default) or "extreme"
---@return boolean available false while no copy of a dated map can be opened yet
---@return string|nil from the date ("YYYY-MM-DD") of the dated copy that opens, or while none
---can, the earliest date one of them opens; nil when no copy is dated or an undated copy opens
local function getMapAvailability(name, game)
    if type(name) ~= "string" or name == "" then return true, nil end
    local which = game == "extreme" and "extreme" or "crusader"
    local now = today()
    for _, pattern in ipairs(EXTRA_DIRS[which == "extreme" and "mapsExtreme\\*.map" or "maps\\*.map"] or {}) do
        activateDatedMaps(pattern, now)
    end
    local keys = {}
    for _, key in ipairs(scheduleKeys(name)) do keys[key] = true end
    local copies, earliest = {}, nil
    for _, lists in pairs(DATED_MAPS) do
        for _, entry in ipairs(lists[which] or {}) do
            if keys[entry.key] then
                table.insert(copies, entry)
                if earliest == nil or entry.from < earliest then earliest = entry.from end
            end
        end
    end
    if #copies == 0 then return true, nil end
    local opens = overrideRegistry.FILE_OVERRIDES[copies[1].trigger:lower()]
    if opens == nil then
        return false, formatDate(earliest)
    end
    for _, entry in ipairs(copies) do
        if entry.registered and (entry.path:gsub("/+", "\\")) == opens then
            return true, formatDate(entry.from)
        end
    end
    return true, nil
end

local function setTodayOverride(value)
    if value == nil or value == "" then
        TODAY_OVERRIDE = nil
        return
    end
    local parsed = parseDate(value)
    if parsed == nil then
        log(WARNING, string.format("map-availability-date: %s ignored (expected a date \"YYYY-MM-DD\")", tostring(value)))
        TODAY_OVERRIDE = nil
        return
    end
    log(INFO, string.format("map-availability-date: dated maps are listed as on %s", value))
    TODAY_OVERRIDE = parsed
end

local function bind(pattern)
    local site, reason = core.AOBScanUnique(pattern)
    assert(site, tostring(reason) .. " (" .. pattern .. ")")
    return site
end

local function RawFindFileInterface()
    local first = bind("8D 4C 24 60 51 57 FF 15 ? ? ? ?")
    local next = bind("8D 4C 24 60 51 52 FF 15 ? ? ? ?")
    local close = bind("FF 15 ? ? ? ? 8B ? ? ? ? ? ? 64 ? ? ? ? ? ? 59")
    local timeZone = bind("FF 15 ? ? ? ? 83 F8 01 75 09")
    local multiply = bind("8B 44 24 08 8B 4C 24 10 0B C8")
    local fileTime = bind("83 F8 FF 89 44 24 24 0F ? ? ? ? ? 81 3E F4 01 00 00")
    local manager = bind("A1 ? ? ? ? 89 46 74 33 C0 39 ? ? ? ? ? 7E 15")

    local findFirst = core.readInteger(core.readInteger(first + 8))
    local findNext = core.readInteger(core.readInteger(next + 8))
    local findClose = core.readInteger(core.readInteger(close + 2))
    local getTimeZone = core.readInteger(core.readInteger(timeZone + 2))
    local convertFileTime = core.readInteger(core.readInteger(fileTime + 27))
    local resourceManager = core.readInteger(manager + 1)

    return {
        FindFirstFileA = core.exposeCode(findFirst, 2, 2),
        FindNextFileA = core.exposeCode(findNext, 2, 2),
        FindClose = core.exposeCode(findClose, 1, 2),
        GetTimeZoneInformation = core.exposeCode(getTimeZone, 1, 2),
        allmul = core.exposeCode(multiply, 4, 2),
        FileTimeToDosDateTime = core.exposeCode(convertFileTime, 3, 2),
        ptr_LoadedMapNames = resourceManager + 0xbc8,
        ptr_MapFileTimeArray = resourceManager + 0x7fd14,
        ptr_ResourceManager = resourceManager,
        ptr_MapFileCounter = resourceManager,
    }
end

local rawInterface

local ptr_timeZoneInformation
local timeZoneOffset = 0 -- 64 bit
local timeZoneOffsetLow = 0
local timeZoneOffsetHigh = 0

local function computeTimeZoneOffset()
    local v = rawInterface.GetTimeZoneInformation(ptr_timeZoneInformation)
    local lowOrder = 0
    local highOrder = 0
    if v == 1 then
        lowOrder = -1 * core.readInteger(ptr_timeZoneInformation + 0x54)
        highOrder = (lowOrder & 0xFFFFFFFF) >> 0x1F
    elseif v == 2 then
        lowOrder = -1 * core.readInteger(ptr_timeZoneInformation + 0xa8)
        highOrder = (lowOrder & 0xFFFFFFFF) >> 0x1F
    end

    timeZoneOffset = rawInterface.allmul(lowOrder, highOrder, 600000000, 0)
    timeZoneOffsetLow = timeZoneOffset & 0xFFFFFFFF
    timeZoneOffsetHigh = (timeZoneOffset >> 0x20) & 0xFFFFFFFF
    return timeZoneOffset
end

local ptr_filetime
local ptr_dosDateTime

local ptr_win32FindData

local function dosTime()
    core.writeInteger(ptr_dosDateTime, 0)

    local low = core.readInteger(ptr_win32FindData + 0x14 + 0) + timeZoneOffsetLow
    local high = core.readInteger(ptr_win32FindData + 0x14 + 4) + timeZoneOffsetHigh
    core.writeInteger(ptr_filetime + 0, low)
    local carry = 0
    if (low >> 0x20) > 0 then carry = 1 end
    core.writeInteger(ptr_filetime + 4, high + carry)

    rawInterface.FileTimeToDosDateTime(ptr_filetime, ptr_dosDateTime + 2, ptr_dosDateTime)

    return core.readInteger(ptr_dosDateTime)
end

local function filename()
    return core.readString(ptr_win32FindData + 0x2c)
end

local ptr_stringBufferThing

local documentsFolder, readDocumentsFolder

local function getDocumentsFolder()
    readDocumentsFolder(rawInterface.ptr_ResourceManager, ptr_stringBufferThing, 1)

    if core.readInteger(ptr_stringBufferThing + 0x18) < 0x10 then
        documentsFolder = core.readString(ptr_stringBufferThing + 0x4)
    else
        documentsFolder = core.readString(core.readInteger(ptr_stringBufferThing + 0x4))
    end

    log(VERBOSE, string.format("getDocumentsFolder: %s", documentsFolder))
end

local ptr_targetPattern

local DiscoveryHandler = {

    new = function(self)
        local o = setmetatable({
            filenames = {},
            filetimes = {},
            count = 0,
        }, self)

        self.__index = self

        return o
    end,

    discoverForPattern = function(self, pattern)
        log(VERBOSE, string.format("discoverForPattern: %s", pattern))

        if self.count >= 500 then return false end

        core.setMemory(ptr_targetPattern, 0, 1001)
        core.writeString(ptr_targetPattern, pattern)
        local handle = rawInterface.FindFirstFileA(ptr_targetPattern, ptr_win32FindData)

        local dated = AVAILABLE_FROM[pattern:lower()]
        local now = dated ~= nil and today() or nil
        local notYet = 0
        if dated ~= nil then
            activateDatedMaps(pattern, now)
        end

        local found = handle ~= -1 and handle ~= 0xFFFFFFFF
        if found then
            while self.count < 500 do
                local name = filename()
                local t = dosTime()

                local from = dated ~= nil and dated[fileKey(name)] or nil
                if not isAvailable(from, now) then
                    log(VERBOSE, string.format("discoverForPattern: %s is listed from %d on", name, from))
                    notYet = notYet + 1
                else
                    if self.filetimes[name:lower()] == nil then
                        log(VERBOSE, string.format("discoverForPattern: discovered new map: %s", name))
                        table.insert(self.filenames, name)
                        self.count = self.count + 1
                    end

                    self.filetimes[name:lower()] = t
                end

                local hasNext = rawInterface.FindNextFileA(handle, ptr_win32FindData)
                if hasNext == 0 then
                    break
                end
            end
        end

        if dated ~= nil then
            log(INFO, string.format("discoverForPattern: %s: %d maps not listed yet (today counts as %s)",
                pattern, notYet, tostring(now)))
        end

        if found then rawInterface.FindClose(handle) end
        return self.count < 500
    end,

    commit = function(self)
        table.sort(self.filenames)

        core.setMemory(rawInterface.ptr_LoadedMapNames, 0, 500 * 1000)

        for i = 1, #self.filenames do
            local name = self.filenames[i]
            local t = self.filetimes[name:lower()]

            local shortname = name

            if name:sub(-4):lower() == ".map" then
                shortname = name:sub(1, -4 - 1)
            elseif name:sub(-4):lower() == ".sav" then
                shortname = name:sub(1, -4 - 1)
            elseif name:sub(-4):lower() == ".msv" then
                shortname = name:sub(1, -4 - 1)
            end

            log(VERBOSE, string.format("commit: committing: %s", shortname))
            core.writeString(rawInterface.ptr_LoadedMapNames + ((i - 1) * 1001), shortname)
            core.writeInteger(rawInterface.ptr_MapFileTimeArray + ((i - 1) * 4), t)
        end

        core.writeInteger(rawInterface.ptr_MapFileCounter, #self.filenames)
    end,

}


local function discoverMapFiles_hook(this, ptr_pattern)
    log(VERBOSE, string.format("discoverMapFiles: %s", core.readString(ptr_pattern)))

    if documentsFolder == nil then getDocumentsFolder() end

    local dh = DiscoveryHandler:new()

    local pattern = core.readString(ptr_pattern)

    local missionMaps = false
    local originalMaps = false
    local originalExtremeMaps = false
    local originalSavs = false
    local originalExtremeSavs = false

    if pattern == "maps\\*.map" then
        missionMaps = true
        originalMaps = true
    elseif pattern == "mapsExtreme\\*.map" then
        missionMaps = true
        originalExtremeMaps = true
    elseif pattern:sub(-("saves\\*.sav"):len()):lower() == "saves\\*.sav" then
        originalSavs = true
    elseif pattern:sub(-("savesextreme\\*.sav"):len()):lower() == "savesextreme\\*.sav" then
        originalExtremeSavs = true
    end

    local patterns = {}

    if originalMaps then
        if not DISABLE_GAME_DIR_MAPS then
            table.insert(patterns, pattern)
        end

        if not DISABLE_USER_DIR_MAPS then
            table.insert(patterns, documentsFolder .. "Maps\\*.map")
        end

        if EXTRA_DIRS[pattern] and #EXTRA_DIRS[pattern] > 0 then
            for _, dir in ipairs(EXTRA_DIRS[pattern]) do
                table.insert(patterns, dir)
            end
        end
    elseif originalExtremeMaps then
        if not DISABLE_GAME_DIR_MAPS_EXTREME then
            table.insert(patterns, pattern)
        end

        if not DISABLE_USER_DIR_MAPS_EXTREME then
            table.insert(patterns, documentsFolder .. "MapsExtreme\\*.map")
        end

        if EXTRA_DIRS[pattern] and #EXTRA_DIRS[pattern] > 0 then
            for _, dir in ipairs(EXTRA_DIRS[pattern]) do
                table.insert(patterns, dir)
            end
        end
    elseif originalSavs then
        if not DISABLE_USER_DIR_SAVS then
            table.insert(patterns, documentsFolder .. "Saves\\*.sav")
        end
    elseif originalExtremeSavs then
        if not DISABLE_USER_DIR_SAVS_EXTREME then
            table.insert(patterns, documentsFolder .. "SavesExtreme\\*.sav")
        end
    else
        log(WARNING, string.format("Unmodified pattern: %s", pattern))
        -- Insert the default requested pattern
        table.insert(patterns, pattern)
    end

    log(VERBOSE, string.format("discoverMapFiles: handler: %s", tostring(dh)))
    log(VERBOSE, string.format("discoverMapFiles: handler: func: %s", tostring(dh.discoverForPattern)))

    for _, p in ipairs(patterns) do
        if dh:discoverForPattern(p) == false then
            log(WARNING, "Too many map files (>499) are being loaded! List of maps will be truncated.")
            break
        end
    end

    dh:commit()
end


local MAP_SUFFIX = ".map"

-- TODO: this can be moved to the discovery logic
---Registers the file redirects for the maps of an extra directory. Dated maps get theirs once
---their date has come (activateDatedMaps), so until then a same-named map elsewhere is used.
---@param dir string the folder, without "\*.map"
---@param dated table<string, number>|nil the directory's dated maps (name key -> yyyymmdd)
---@param fnfDir string|nil the directory's FindFirstFile pattern
local function registerOverridesForDirectory(dir, extreme, dated, fnfDir)
    log(DEBUG, "registerOverridesForDirectory: Registering map files in: " .. tostring(dir))

    local status, results = pcall(function()
        return ucp.internal.io.files(dir)
    end)

    if status == nil or status == false then
        log(WARNING, string.format("Cannot register directory. Folder does not exist: %s", tostring(dir)))
        log(WARNING, string.format("Accompanying error message: %s", results))
        return
    end

    local lists = fnfDir ~= nil and DATED_MAPS[fnfDir:lower()] or nil
    local datedList = lists ~= nil and lists[extreme and "extreme" or "crusader"] or nil

    for k, path in ipairs(results) do
        local fileName = path:match("([^/\\]+)$") or path
        if fileName:sub(-MAP_SUFFIX:len()):lower() == MAP_SUFFIX then
            local mapName = fileName:sub(1, -MAP_SUFFIX:len() - 1)

            local trigger = "maps\\" .. mapName .. ".map"
            if extreme then
                trigger = "mapsExtreme\\" .. mapName .. ".map"
            end
            local from = dated ~= nil and dated[fileKey(fileName)] or nil
            if from ~= nil and datedList ~= nil then
                log(DEBUG, "registerOverridesForDirectory: files(): " .. tostring(trigger) .. " => " .. tostring(path) .. " from " .. tostring(from))
                -- a redirect left by an earlier registration of this folder waits for the date too
                local existing = overrideRegistry.FILE_OVERRIDES[trigger:lower()]
                if existing ~= nil and existing == (path:gsub("/+", "\\")) then
                    overrideRegistry.FILE_OVERRIDES[trigger:lower()] = nil
                end
                table.insert(datedList, { trigger = trigger, key = fileKey(fileName), path = path, from = from, registered = false })
            else
                log(DEBUG, "registerOverridesForDirectory: files(): Registering " .. tostring(trigger) .. " => " .. tostring(path))
                modules.files:overrideFileWith(trigger, path)
            end
        end
    end
end

local function registerExtraDir(target, dir)
    log(VERBOSE, "Registering extra directory: " .. tostring(dir))

    -- local addr = core.allocate(dir:len() + 1)
    -- core.writeString(addr, dir)
    -- core.writeByte(addr + dir:len(), 0)
    if EXTRA_DIRS[target] == nil then
        EXTRA_DIRS[target] = { [1] = dir }
    else
        table.insert(EXTRA_DIRS[target], dir)
    end
end

local function prepareDir(dir, ext)
    -- FindNextFile Directory should end with *.map
    local fnfDir = dir

    if dir:sub(-1) == "\\" or dir:sub(-1) == "/" then
        fnfDir = dir .. string.format("*.%s", ext)
    end
    if fnfDir:sub(-6) ~= string.format("\\*.%s", ext) and fnfDir:sub(-6) ~= string.format("/*.%s", ext) then
        fnfDir = fnfDir .. string.format("\\*.%s", ext)
    end

    fnfDir = ucp.internal.resolveAliasedPath(fnfDir)

    return fnfDir
end

return {
    getMapAvailability = getMapAvailability,

    setOption = function(key, value)
        if key == "disable-game-maps" then
            if value == true then
                DISABLE_GAME_DIR_MAPS = true
            else
                DISABLE_GAME_DIR_MAPS = false
            end
        end

        if key == "disable-game-maps-extreme" then
            if value == true then
                DISABLE_GAME_DIR_MAPS_EXTREME = true
            else
                DISABLE_GAME_DIR_MAPS_EXTREME = false
            end
        end

        if key == "disable-user-maps" then
            if value == true then
                DISABLE_USER_DIR_MAPS = true
            else
                DISABLE_USER_DIR_MAPS = false
            end
        end

        if key == "disable-user-maps-extreme" then
            if value == true then
                DISABLE_USER_DIR_MAPS_EXTREME = true
            else
                DISABLE_USER_DIR_MAPS_EXTREME = false
            end
        end

        if key == "disable-user-savs" then
            if value == true then
                DISABLE_USER_DIR_SAVS = true
            else
                DISABLE_USER_DIR_SAVS = false
            end
        end

        if key == "disable-user-savs-extreme" then
            if value == true then
                DISABLE_USER_DIR_SAVS_EXTREME = true
            else
                DISABLE_USER_DIR_SAVS_EXTREME = false
            end
        end

        if key == "extra-map-directory" then
            if value:len() > 0 then
                local dir = folderOf(value)
                log(DEBUG, string.format('extra-map-directory: %s', dir))

                -- FindNextFile Directory should end with *.map
                local fnfDir = prepareDir(dir, "map")

                log(DEBUG, "Registering extra map dir: " .. tostring(fnfDir))

                local dated = registerAvailability(fnfDir, dir, { crusader = true })
                registerExtraDir("maps\\*.map", fnfDir)
                -- registerExtraDir("mapsExtreme\\*.map", fnfDir)

                registerOverridesForDirectory(dir, false, dated, fnfDir)
                activateDatedMaps(fnfDir, today())
            else
                log(DEBUG, "No extra map directory found in the config")
            end
        end

        if key == "extra-map-extreme-directory" then
            if value:len() > 0 then
                local dir = folderOf(value)
                log(DEBUG, string.format('extra-map-extreme-directory: %s', dir))

                -- FindNextFile Directory should end with *.map
                local fnfDir = prepareDir(dir, "map")

                log(DEBUG, "Registering extra map extreme dir: " .. tostring(fnfDir))

                local dated = registerAvailability(fnfDir, dir, { extreme = true })
                -- registerExtraDir("maps\\*.map", fnfDir)
                registerExtraDir("mapsExtreme\\*.map", fnfDir)

                registerOverridesForDirectory(dir, true, dated, fnfDir)
                activateDatedMaps(fnfDir, today())
            else
                log(DEBUG, "No extra map extreme directory found in the config")
            end
        end

        if key == "extra-sav-directory" then
            --TODO: how to know the target? We don't know the user username and the documents path?
            --registerExtraDir("maps\\*.map", config["extra-sav-directory"])
            print("WARNING: not implemented: 'extra-sav-directory'")
        end

        if key == "map-availability-date" then
            setTodayOverride(value)
        end
    end,

    enable = function(config)
        if type(config) == "table" and config["map-availability-date"] ~= nil then
            setTodayOverride(config["map-availability-date"])
        end

        local ok, reason = pcall(function()
            local site = bind("6A FF 68 ? ? ? ? 64 A1 00 00 00 00 50 81 EC 3C 02 00 00")
            local documents = bind("6A FF 68 ? ? ? ? 64 A1 00 00 00 00 50 83 EC 40 A1 ? ? ? ? 33 C4 89 44 24 3C 53 55 56 57 A1 ? ? ? ? 33 C4 50 8D 44 24 54 64 A3 00 00 00 00 8B 7C 24 64 33 DB 6A 15")
            rawInterface = RawFindFileInterface()
            readDocumentsFolder = core.exposeCode(documents, 3, 1)
            ptr_timeZoneInformation = core.allocate(172)
            ptr_filetime = core.allocate(8)
            ptr_dosDateTime = core.allocate(4)
            ptr_win32FindData = core.allocate(320)
            ptr_stringBufferThing = core.allocate(28)
            ptr_targetPattern = core.allocate(1001)
            core.hookCode(discoverMapFiles_hook, site, 2, 1, 7)
        end)
        if not ok then log(ERROR, "Files map discovery is off: " .. tostring(reason)) end
    end,

    ---Register an extra map directory for Crusader, Crusader Extreme, or both (default)
    ---@param path string The folder containing the maps
    ---@param which string Either "both", "crusader" or "extreme" indicating which game should load these maps
    ---@return void
    registerExtraMapDirectory = function(path, which)
      if which == nil or which == "both" then
        which = "both"
      elseif which == "extreme" then
        which = "extreme"
      else
        which = "crusader"
      end

      local dir = folderOf(path)

      -- FindNextFile Directory should end with *.map
      local fnfDir = prepareDir(dir, "map")

      local games = {}
      if which == "both" or which == "crusader" then games.crusader = true end
      if which == "both" or which == "extreme" then games.extreme = true end
      local dated = registerAvailability(fnfDir, dir, games)

      if which == "both" or which == "crusader" then
        log(DEBUG, "Registering extra map crusader dir: " .. tostring(fnfDir))
        registerExtraDir("maps\\*.map", fnfDir)
        -- registerExtraDir("mapsExtreme\\*.map", fnfDir)

        registerOverridesForDirectory(dir, false, dated, fnfDir)
      end

      if which == "both" or which == "extreme" then
        log(DEBUG, "Registering extra map crusader extreme dir: " .. tostring(fnfDir))
              -- registerExtraDir("maps\\*.map", fnfDir)
        registerExtraDir("mapsExtreme\\*.map", fnfDir)

        registerOverridesForDirectory(dir, true, dated, fnfDir)
      end

      activateDatedMaps(fnfDir, today())
    end,
}
