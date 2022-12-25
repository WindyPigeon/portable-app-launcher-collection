# Important changes of Arduino

## 0013
 ![2009.02.06](https://img.shields.io/badge/release_date-february_2009-informational)

 ![](IconFiles/AppIcon/0000/appicon_32.png)

## 0017
 ![2010.07.25](https://img.shields.io/badge/release_date-july_2010-informational)

- New application icon.

  ![](IconFiles/AppIcon/0017/appicon_32.png)

## 0020
 ![2010.09.27](https://img.shields.io/badge/release_date-september_2010-informational)

- New application icon.

  ![](IconFiles/AppIcon/0020/appicon_32.png)

## 1.0.1
 ![2012.05.21](https://img.shields.io/badge/release_date-may_2012-informational)

- Multilingual support.
  - *Arabic*, *Aragonese*, *Catalan*, *Chinese Simplified*, *Chinese Traditional*, *Danish*, *Dutch*, *English*, *Estonian*, *Filipino*, *Finnish*, *French*, *Galician*, *German*, *Greek*, *Hindi*, *Hungarian*, *Indonesian*, *Italian*, *Japanese*, *Korean*, *Latvian*, *Lithuaninan*, *Marathi*, *Norwegian*, *Persian*, *Polish*, *Portuguese (Brazil)*, *Portuguese (Portugal)*, *Romanian*, *Russian*, *Spanish* and *Tamil*.

## 1.5.2
 ![2013.02.06](https://img.shields.io/badge/release_date-february_2013-informational)

- The application is run in portable mode if there is a *portable* directory in root directory of the application.

- New languages:
  - *Bulgarian*, *Canadian French*, *Georgian*, *Hebrew*, *Norwegian Bokmål*, *Turkish* and *Ukrainian*.

## 1.5.3
 ![2013.08.30](https://img.shields.io/badge/release_date-august_2013-informational)

- The path of *preference.txt* is changed from

  ```
    C:\Users\<USERNAME>\AppData\Roaming\Arduino
  ```

  to

  ```
    C:\Users\<USERNAME>\AppData\Roaming\Arduino15
  ```

## 1.5.4
 ![2013.09.10](https://img.shields.io/badge/release_date-september_2013-informational)

- Change of language code:
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

- The *Norwegian* language is deprecated and completely replaced by *Norwegian Bokmål*.

- The *Hebrew* language is dropped.

## 1.5.5
 ![2013.11.28](https://img.shields.io/badge/release_date-november_2013-informational)

- New languages:
  - *Belarusian*, *Finnish*, *Slovenian*, *Swedish* and *Vietnamese*.

- The *Marathi* language is dropped.

- The *Hebrew* language is return.

## 1.5.6
 ![2014.02.20](https://img.shields.io/badge/release_date-february_2014-informational)

- New languages:
  - *Albanian*, *English (United Kingdom)* and *Estonian (Estonia)*.

## 1.6.2
 ![2015.03.28](https://img.shields.io/badge/release_date-march_2015-informational)

- Appended files and directories in *Arduino15* directory:
  - files:
    - *package_index.json*
    - *library_index.json*
  - directory:
    - *packages\arduino*

## 1.6.3
 ![2015.04.02](https://img.shields.io/badge/release_date-april_2015-informational)

- *packages* directory in *Arduino15* folder is deprecated.

## 1.6.4
 ![2015.05.06](https://img.shields.io/badge/release_date-may_2015-informational)

- Appended a signature file for *package_index.json* (*package_index.json.sig*) in *Arduino15* folder.

## 1.6.6
 ![2015.11.03](https://img.shields.io/badge/release_date-november_2015-informational)

- The app data folder (*Arduino15*) moved from roaming data folder

  ```
    C:\Users\<USERNAME>\AppData\Roaming\Arduino15
  ```

  to local app data folder

  ```
    C:\Users\<USERNAME>\AppData\Local\Arduino15
  ```

- New languages:
  - *Basque*, *Chinese (Taiwan) (Big5)*, *Galician (Spain)*, *Portuguese*, *Slovak*

- *Danish* language is dropped.

## 1.6.7
 ![2015.12.17](https://img.shields.io/badge/release_date-december_2015-informational)

- New languages:
  - *Afrikaans*, *Armenian*, *Asturian*, *Bosnian*, *Burmese (Myanmar)*, *Dutch (Nederlands)*, *Nepali*, *Persian (Iran)*, *Tolossan* and *Western Frisian*

- *Danish* language and *Marathi* language is return.

## 1.6.8
 ![2016.08.17](https://img.shields.io/badge/release_date-august_2016-informational)

- New languages:
  - *Thai*

## 1.6.11
 ![2016.03.09](https://img.shields.io/badge/release_date-march_2016-informational)

- *library_index.json*, *package_index.json* and *package_index.json.sig* is deprecated

- New languages:
  - *Acoli* and *Telugu*

## 1.8.6
 ![2018.08.23](https://img.shields.io/badge/release_date-august_2018-informational)

- The path of app data folder (*Arduino15*) is determined by the value of *USERPROFILE* environment variable.


## 1.8.10
 ![2019.09.13](https://img.shields.io/badge/release_date-september_2019-informational)

- New directories:
  - *logs*

## 1.8.13
 ![2020.06.16](https://img.shields.io/badge/release_date-june_2020-informational)

- New application icon.

  ![](IconFiles/AppIcon/1.8.13/appicon_32.png)

## 1.8.18
 ![2021.12.14](https://img.shields.io/badge/release_date-december_2021-informational)

- New directories:
  - *cache*

- *package_index.json* and *package_index.json.sig* are return.

## 2.0.0
 ![](https://img.shields.io/badge/release_date-september_2022-informational)

- New application name:
  - *Arduino* -> *Arduino IDE*.

- New application identifier:
  - *cc.arduino.Arduino* -> *cc.arduino.IDE2*.

- New application icon.

  ![](IconFiles/AppIcon/2.0.0/appicon_32.png)

- New directories:
  - *.arduinoIDE*
    - In Windows: `%USERPROFILE%\.arduinoIDE`
    - In MacOS:   `~/.arduinoIDE`

  - *arduino-ide*
    - In Windows: `%USERPROFILE%\AppData\Roaming\arduino-ide`
    - In MacOS:   `~/Library/Application Support/arduino-ide`

- The association of *c*, *cpp* and *h* extensions are deprecated.
