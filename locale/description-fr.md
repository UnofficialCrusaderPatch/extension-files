# Files

L’extension s’appelle « files », car elle intercepte les opérations sur les fichiers du jeu. Elle peut notamment rediriger certains appels `open` vers les fichiers de votre choix. Elle sert ainsi de base à de nombreuses extensions qui modifient l’ouverture des fichiers.

## Utilisation

L’extension fournit quatre fonctions :

Remplace l’ouverture d’un fichier précis. Le jeu utilise des chemins Windows tels que `maps\Close Encounters.map`. `file` est le chemin d’origine utilisé par le jeu et `newFile` celui du fichier de remplacement.

```lua
modules.files:overrideFileWith(file, newFile)
```

Enregistre une fonction de redirection appelée à chaque ouverture de fichier. Utile pour les fichiers chargés plusieurs fois pendant la partie plutôt qu’une seule.

```lua
modules.files:registerOverrideFunction(func)
```

Utilisée par maploader pour régler les paramètres de chargement des fichiers `.map` et `.sav` du jeu.

```lua
modules.files:setIterationOption(key, value)
```

Définit un autre emplacement où rechercher les fichiers du jeu, uniquement pour `gm`, `gfx`, `fx` et `binks`. Les cartes doivent être enregistrées auprès de maploader.

```lua
modules.files:registerFileSource(path)
```
