# Files
Cette extension s’appelle « files » parce qu’elle intercepte les opérations sur les fichiers effectuées par le jeu.

Une fonction clé consiste à intercepter certaines opérations `open` pour les rediriger vers des fichiers choisis.

Cette extension fournit le moteur de nombreuses extensions reposant sur l’interception de l’opération `open`.

## Utilisation
Cette extension fournit cinq fonctions :
```lua
--[[
Remplace/intercepte l'opération open pour un fichier précis.
Le jeu utilise des chemins Windows, tels que "maps\\Close Encounters.map".

file  string  le chemin d'origine utilisé par le jeu
newfile  string  le chemin du fichier qui remplacera l'original
--]]
modules.files:overrideFileWith(file, newFile)

--[[
Enregistre une fonction de remplacement appelée à chaque opération open.
Utile pour les fichiers chargés plusieurs fois pendant la partie plutôt qu'une seule fois.
--]]
modules.files:registerOverrideFunction(func)

--[[
Utilisée par l'extension maploader pour définir les paramètres de chargement des fichiers .amp et .sav du jeu.
--]]
modules.files:setIterationOption(key, value)

--[[
Définit un emplacement alternatif où le jeu cherche ses fichiers (uniquement gm, gfx, fx, binks).
Les cartes doivent être enregistrées avec maploader.
--]]
modules.files:registerFileSource(path)

--[[
Ajoute un dossier de fichiers .map aux listes de cartes du jeu. `which` vaut "both" (par défaut), "crusader" ou "extreme".
Plusieurs dossiers peuvent être enregistrés, par exemple un par plugin.
--]]
modules.files:registerExtraMapDirectory(path, which)

```

## Cartes apparaissant à partir d’une date
Un dossier de cartes supplémentaire peut contenir un fichier `availability.json` qui n’affiche certaines cartes qu’à partir d’une date donnée, à l’heure locale du joueur, pour les packs ouvrant une carte par jour. Le format figure dans le [README](https://github.com/UnofficialCrusaderPatch/extension-files/blob/main/README.md).
