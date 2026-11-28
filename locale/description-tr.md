# Files
Bu uzantı, oyunun gerçekleştirdiği dosya işlemlerini yakaladığı için «files» adını taşır.

Temel özelliği, belirli `open` dosya işlemlerini yakalayıp seçilen dosyalara yönlendirmektir.

Bu uzantı, `open` işlemini yakalamaya dayanan birçok uzantının altyapısını sağlar.

## Kullanım
Bu uzantı beş işlev sunar:
```lua
--[[
Belirli bir dosya için open işlemini geçersiz kılar/yakalar.
Oyunun Windows tarzı yollar kullandığını unutmayın, örn. "maps\\Close Encounters.map".

file  string  oyunun kullandığı özgün yol
newfile  string  özgün dosyanın yerini alacak dosyanın yolu
--]]
modules.files:overrideFileWith(file, newFile)

--[[
Her open işlemi çağrıldığında çalışan bir geçersiz kılma işlevi kaydeder.
Yalnızca bir kez değil, oyun boyunca sık sık yüklenen dosyalar için yararlıdır.
--]]
modules.files:registerOverrideFunction(func)

--[[
Oyunun .amp ve .sav dosya yükleme parametrelerini ayarlamak için maploader uzantısı tarafından kullanılır.
--]]
modules.files:setIterationOption(key, value)

--[[
Oyunun oyun dosyalarını arayacağı alternatif bir konum tanımlar (yalnızca gm, gfx, fx, binks).
Haritalar maploader ile kaydedilmelidir.
--]]
modules.files:registerFileSource(path)

--[[
.map dosyalarını içeren bir klasörü oyunun harita listelerine ekler. `which` değeri "both" (varsayılan), "crusader" veya "extreme" olabilir.
Örneğin her eklenti için bir klasör olmak üzere birden fazla klasör kaydedilebilir.
--]]
modules.files:registerExtraMapDirectory(path, which)

```

## Belirli bir tarihten itibaren görünen haritalar
Ek bir harita klasörü, günde bir harita açan paketler için oyuncunun yerel saatine göre haritaları yalnızca belirtilen tarihten itibaren listeleyen bir `availability.json` dosyası içerebilir. Biçim için [README](https://github.com/UnofficialCrusaderPatch/extension-files/blob/main/README.md) dosyasına bakın.
