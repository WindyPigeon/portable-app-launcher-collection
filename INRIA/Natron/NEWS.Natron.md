# Natron NEWS

## Version 2.4.0
 ![](https://img.shields.io/badge/release_date-april_2021-informational)
- The publisher name in the app installer has been changed to "The Natron developers".

  See the [source code](https://github.com/NatronGitHub/Natron/blob/v2.4.0/tools/MINGW-packages/mingw-w64-natron-setup/Natron.iss#L4).

## Version 2.3.15
 ![](https://img.shields.io/badge/release_date-june_2020-informational)
- Product URL is updated.
  - http://www.natron.fr -> https://natrongithub.github.io

  See the [source code](https://github.com/NatronGitHub/Natron/blob/v2.3.15/tools/jenkins/include/config/Windows.xml#L8).

## Version 2.2.9
 ![](https://img.shields.io/badge/release_date-june_2017-informational)

- New feature: Customize the disk cache path with environment variable.
  - `NATRON_DISK_CACHE_PATH`

  See the [source code](https://github.com/NatronGitHub/Natron/blob/v2.2.9/Global/Macros.h#L255).

## Version 2.0.0
 ![](https://img.shields.io/badge/release_date-march_2016-informational)

- Add new file extension association.
  - *nl* (Natron Layout)

  See the [source code](https://github.com/NatronGitHub/Natron/blob/v2.0.0/App/NatronInfo.plist#L62).

## Version 1.0.0
 ![](https://img.shields.io/badge/release_date-december_2014-informational)

- New application icon.
  - ![](IconFiles/AppIcon/1.0.0/appicon_128.png)

- With project icon.
  - ![](IconFiles/FileTypeIcons/1.0.0/AllOtherIcons_32.png)

- Add new file extension association.
  - *nps* (Natron Node Presets)

  See the [source code](https://github.com/NatronGitHub/Natron/blob/v1.0.0/App/NatronInfo.plist#L44).

- New feature: Customize the disk cache path with registry key / configuration file:
  - Windows: `diskCachePath` value of `HKEY_CURRENT_USER\Software\INRIA\Natron` registry key
  - Mac: Store in *com.inria.Natron.plist* file with XPath `//plist/dict/key["diskCachePath"]/following-sibling::string`
  - Using forward slash as separator.
  - The directory must exist.
  - Only *DiskCache* and *ViewerCache* directory is determined by this value. This configuration does not affect the file path of *OFXCache.xml*.

  See the [source code](https://github.com/NatronGitHub/Natron/blob/v1.0.0/Engine/Settings.cpp#L685-L697).

## Version 0.9.3
 ![](https://img.shields.io/badge/release_date-june_2014-informational)

![](IconFiles/AppIcon/0.9.3/appicon_128.png)

- Identifier: `fr.inria.Natron`

- Publisher: INRIA

- File extension associations:
  - *ntp* (Natron Project File)

  See the [source code](https://github.com/NatronGitHub/Natron/blob/v0.9.3/App/NatronInfo.plist#L24).

- Without project icon.

- Autosaves directory is fixed.

  See the [source code](https://github.com/NatronGitHub/Natron/blob/v0.9.3/Engine/Project.cpp#L1057).
