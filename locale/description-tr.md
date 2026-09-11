# Files

Uzantının adı “files”dır, çünkü oyunun dosya işlemlerini yakalar. Özellikle belirli `open` çağrılarını seçilen dosyalara yönlendirebilir. Böylece dosya açma işlemini değiştiren birçok uzantıya temel sağlar.

## Kullanım

Uzantı dört işlev sağlar:

Belirli bir dosyanın açılmasını değiştirir. Oyun `maps\Close Encounters.map` gibi Windows yolları kullanır. `file` oyunun özgün yolu, `newFile` ise onun yerini alacak dosyanın yoludur.

```lua
modules.files:overrideFileWith(file, newFile)
```

Her dosya açılışında çağrılan bir yönlendirme işlevi kaydeder. Oyun boyunca yalnızca bir kez değil, tekrar tekrar yüklenen dosyalar için yararlıdır.

```lua
modules.files:registerOverrideFunction(func)
```

maploader tarafından oyunun `.map` ve `.sav` yükleme parametrelerini ayarlamak için kullanılır.

```lua
modules.files:setIterationOption(key, value)
```

Oyun dosyaları için alternatif arama yeri belirler; yalnızca `gm`, `gfx`, `fx` ve `binks` için geçerlidir. Haritalar maploader ile kaydedilmelidir.

```lua
modules.files:registerFileSource(path)
```
