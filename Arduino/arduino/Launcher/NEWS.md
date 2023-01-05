# Arduino Portable Launcher NEWS

## Version 1.6.8
- New translation: th.

## Version 1.6.7
- New translation: af, hy, bs, and my_MM.
- Returned translations: da_DK.

## Version 1.6.6
- New translation: eu, gl, and sk.
- Dropped translation: da_DK.

## Version 1.5.6
- New translations: sq, en_UK, and et.

## Version 1.5.5
- New translations: be, fi, sl, sv and vi.
- Return of translation: he.

## Version 1.5.4
- Change of language codes.
  hr, cs, da, de, el, it, ja, ko, lv and lt are now written in `<Language>_<Territory>` format, which is hr_HR, cs_CZ, da_DK, de_DE, el_GR, it_IT, ja_JP, ko_KR, lv_LV and lt_LT. The territory part of zh_cn, zh_tw, ka_ge, nb_no, pt_br and pt_pt are capitalized.
- Dropped translation: he.

## Version 1.5.3
- The *Data\Library\Arduino* directory is replaced by the *Data\Library\Arduino15* directory.

## Version 1.5.2
- Arduino Portable launcher creates a *portable* directory in the Arduino root directory before running Arduino so that Arduino saves data in this directory.
  - Arduino Portable Launcher saves all files and directories in *App\Arduino\portable* directory to *Data\Library\Arduino* directory after Arduino is closed.
- New translations: bg, ka_ge, he, tr, and uk.

## Version 1.0.1
- Multilingual support. Automatic switching translations for ar, ca, zh_cn, zh_TW, da, nl, en, et, tl, fr, gl, de, el, hi, hu, id, it, ja, ko, lt, lv, nb_no, fa, pl, pt_br, pt_pt, ro, ru, es, and ta when launched from the PortableApps.com Platform.

## Version 0001
- Arduino Portable launcher save all files and directories in `%SystemDrive%\Users\%USERNAME%\AppData\Roaming\Arduino` directory to `Data\Library\Arduino` directory.

- The first run of the Arduino Portable launcher will initialize the `sketchbook.path` (the project folder) in *Library\Arduino\preferences.txt* to `%PortableApps.comDocuments%\Arduino` directory.

