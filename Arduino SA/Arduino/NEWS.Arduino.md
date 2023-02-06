# Arduino / Arduino IDE NEWS

## ARDUINO 1.8.18
 ![2021.12.14](https://img.shields.io/badge/release_date-december_2021-informational)

- New directories:
  - *cache*

- *package_index.json* and *package_index.json.sig* are return.

## ARDUINO 1.8.13
 ![2020.06.16](https://img.shields.io/badge/release_date-june_2020-informational)

- New application icon.

  ![](Icons/AppIcon/1.8.13/appicon_32.png)

## ARDUINO 1.8.10
 ![2019.09.13](https://img.shields.io/badge/release_date-september_2019-informational)

- New directories:
  - *logs*


## ARDUINO 1.8.6
 ![2018.08.23](https://img.shields.io/badge/release_date-august_2018-informational)

- The path of app data folder (*Arduino15*) is determined by the value of *USERPROFILE* environment variable.

## ARDUINO 1.8.2
 ![2017.03.22](https://img.shields.io/badge/release_date-march_2017-informational)
- Add help link, bugtracker link, translation link and donation link in AppStream metadata.

  View the [source code](https://github.com/arduino/Arduino/blob/1.8.2/build/linux/dist/appdata.xml#L36-L39).

## ARDUINO 1.6.11
 ![2016.03.09](https://img.shields.io/badge/release_date-march_2016-informational)

- *library_index.json*, *package_index.json* and *package_index.json.sig* is deprecated.

- New translations: *Acoli* and *Telugu*.

## ARDUINO 1.6.8
 ![2016.08.17](https://img.shields.io/badge/release_date-august_2016-informational)

- New translation: *Thai*.

## ARDUINO 1.6.7
 ![2015.12.17](https://img.shields.io/badge/release_date-december_2015-informational)

- New translations: *Afrikaans*, *Armenian*, *Asturian*, *Bosnian*, *Burmese (Myanmar)*, *Dutch (Nederlands)*, *Nepali*, *Persian (Iran)*, *Tolossan* and *Western Frisian*.

- *Danish* and *Marathi* translation is return.

- Change `GenericName` of application to `Arduino IDE` in desktop entry.

  View the [source code](https://github.com/arduino/Arduino/blob/1.6.7/build/linux/dist/desktop.template#L4).

## ARDUINO 1.6.6
 ![2015.11.03](https://img.shields.io/badge/release_date-november_2015-informational)

- The app category is set to `public.app-category.education`.

  View the [source code](https://github.com/arduino/Arduino/blob/1.6.6/build/build.xml#L312).

- The app data folder (*Arduino15*) moved from roaming data folder

  ```
  C:\Users\<USERNAME>\AppData\Roaming\Arduino15
  ```

  to local app data folder

  ```
  C:\Users\<USERNAME>\AppData\Local\Arduino15
  ```

- New translations: *Basque*, *Chinese (Taiwan) (Big5)*, *Galician (Spain)*, *Portuguese*, and *Slovak*.

- *Danish* translation is dropped.

## ARDUINO 1.6.4
 ![2015.05.06](https://img.shields.io/badge/release_date-may_2015-informational)

- Appended a signature file for *package_index.json* (*package_index.json.sig*) in *Arduino15* folder.

## ARDUINO 1.6.3
 ![2015.04.02](https://img.shields.io/badge/release_date-april_2015-informational)

- *packages/* directory in *Arduino15/* directory is deprecated.

## ARDUINO 1.6.2
 ![2015.03.28](https://img.shields.io/badge/release_date-march_2015-informational)

- Appended files and directories in *Arduino15/* directory:
  - files:
    - *package_index.json*
    - *library_index.json*
  - directory:
    - *packages/arduino/*

## ARDUINO 1.5.6
 ![2014.02.20](https://img.shields.io/badge/release_date-february_2014-informational)

- New translations: *Albanian*, *English (United Kingdom)* and *Estonian (Estonia)*.

- Add AppStream metadata and desktop entry file.
  View the original [AppStream metadata](https://github.com/arduino/Arduino/blob/1.5.6/build/linux/dist/appdata.xml) and [desktop entry](https://github.com/arduino/Arduino/blob/1.5.6/build/linux/dist/arduino.desktop) on GitHub.

## ARDUINO 1.5.5
 ![2013.11.28](https://img.shields.io/badge/release_date-november_2013-informational)

- New translations: *Belarusian*, *Finnish*, *Slovenian*, *Swedish* and *Vietnamese*.

- The *Marathi* translation is dropped.

- The *Hebrew* translation is return.

## ARDUINO 1.5.4
 ![2013.09.10](https://img.shields.io/badge/release_date-september_2013-informational)

- Change of language codes:
  - Croatian:             `hr` -> `hr_HR`
  - Czech:                `cs` -> `cs_CZ`
  - Chinese Simplified:   `zh_cn` -> `zh_CN`
  - Chinese Traditional:  `zh_tw` -> `zh_TW`
  - Dutch:                `da` -> `da_DK`
  - Canadian French:      `fr_ca` -> `fr_CA`
  - Georgian:             `ka_ge` -> `ka_GE`
  - German:               `de` -> `de_DE`
  - Greek:                `el` -> `el_GR`
  - Italian:              `it` -> `it_IT`
  - Japanese:             `ja` -> `ja_JP`
  - Korean:               `ko` -> `ko_KR`
  - Latvian:              `lv` -> `lv_LV`
  - Lithuaninan:          `lt` -> `lt_LT`
  - Norwegian Bokmål:     `nb_no` -> `nb_NO`
  - Portuguese (Brazil):  `pt_br` -> `pt_BR`
  - Portuguese (Portugal):`pt_pt` -> `pt_PT`

- The *Norwegian* translation is deprecated and completely replaced by *Norwegian Bokmål*.

- The *Hebrew* translation is dropped.

## ARDUINO 1.5.3
 ![2013.08.30](https://img.shields.io/badge/release_date-august_2013-informational)

- The path of *preference.txt* is changed from

  ```
  C:\Users\<USERNAME>\AppData\Roaming\Arduino
  ```

  to

  ```
  C:\Users\<USERNAME>\AppData\Roaming\Arduino15
  ```

## ARDUINO 1.5.2
 ![2013.02.06](https://img.shields.io/badge/release_date-february_2013-informational)

- The application is run in portable mode if there is a *portable/* directory in root directory of the application.

- New translations: *Bulgarian*, *Canadian French*, *Georgian*, *Hebrew*, *Norwegian Bokmål*, *Turkish* and *Ukrainian*.


## ARDUINO 1.0.1
 ![2012.05.21](https://img.shields.io/badge/release_date-may_2012-informational)

- Multilingual support. Translations for *Arabic*, *Aragonese*, *Catalan*, *Chinese Simplified*, *Chinese Traditional*, *Danish*, *Dutch*, *English*, *Estonian*, *Filipino*, *French*, *Galician*, *German*, *Greek*, *Hindi*, *Hungarian*, *Indonesian*, *Italian*, *Japanese*, *Korean*, *Latvian*, *Lithuaninan*, *Marathi*, *Norwegian*, *Persian*, *Polish*, *Portuguese (Brazil)*, *Portuguese (Portugal)*, *Romanian*, *Russian*, *Spanish* and *Tamil*.

## ARDUINO 1.0
 ![2011.11.30](https://img.shields.io/badge/release_date-november_2011-informational)

- New document icon（Mac only).
  
  ![](Icons/FileTypeIcons/1.0/AllOtherIcons_32.png)

  View the original file on [GitHub](https://raw.githubusercontent.com/arduino/Arduino/1.0/build/macosx/template.app/Contents/Resources/pde.icns).

## ARDUINO 0020
 ![2010.09.27](https://img.shields.io/badge/release_date-september_2010-informational)

- New application icon.

  ![](Icons/AppIcon/0020/appicon_32.png)

  View the original file on [GitHub](https://raw.githubusercontent.com/arduino/Arduino/0020/build/windows/launcher/application.ico).

## ARDUINO 0017
 ![2009.07.25](https://img.shields.io/badge/release_date-july_2009-informational)

- New application icon.

  ![](Icons/AppIcon/0017/appicon_32.png)

  View the original file on [GitHub](https://raw.githubusercontent.com/arduino/Arduino/0017/build/windows/launcher/application.ico).

- New document icon（Mac only).
  
  ![](Icons/FileTypeIcons/0017/AllOtherIcons_32.png)

  View the original file on [GitHub](https://raw.githubusercontent.com/arduino/Arduino/0017/build/macosx/dist/Arduino.app/Contents/Resources/pde.icns).

- New file extension association: *java*.

  View the [source code](https://github.com/arduino/Arduino/blob/0017/build/macosx/dist/Arduino.app/Contents/Info.plist).

## ARDUINO 0011
 ![2008.03.28](https://img.shields.io/badge/release_date-march_2008-informational)

- New identifier: `cc.arduino.Arduino`

- New file extension association:
  - Arduino Source File: *pde*.

  View the [source code](https://github.com/arduino/Arduino/blob/0011/build/macosx/Arduino.xcodeproj/project.pbxproj#L69).

- Create reference files with Perl Script.

  View the [source code](https://github.com/arduino/Arduino/blob/0011/build/create_reference.pl).

## ARDUINO 0003
 ![2006.01.16](https://img.shields.io/badge/release_date-january_2006-informational)

- New application icon.

  ![](Icons/AppIcon/0003/appicon_32.png)

- The bundle identifier is removed.

- The file extension associations are removed.

  View the original file on [GitHub](https://raw.githubusercontent.com/arduino/Arduino/0005/build/windows/launcher/application.ico).

- Add application's [website](http://arduino.berlios.de/) and [forum link](http://arduino.berlios.de/cgi-bin/yabb/YaBB.cgi) in *readme.txt*.

- Add archive of reference files.

## ARDUINO 0001
 ![2005.08.25](https://img.shields.io/badge/release_date-august_2005-informational)

- Identifier: `de.berlios.arduino`

  View the [source code](https://github.com/arduino/Arduino/blob/0002/build/macosx/dist/Arduino.app/Contents/Info.plist#L37).

- Application icon

  ![](Icons/AppIcon/0002/appicon_32.png)

  View the original file on [GitHub](https://raw.githubusercontent.com/arduino/Arduino/0002/build/windows/launcher/application.ico).
