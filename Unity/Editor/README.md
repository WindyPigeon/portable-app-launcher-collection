# Unity Editor Portable

## About Unity Editor Portable Launcher
 For some reason, we wrote another native launcher for Unity Portable using NSIS scripts in addition to Unity Portable powered by PAL.

### Comparison between **native Launcher** and **PAL**

| NSIS Script | PAL |
| ----------- | --- |
| Can be packaged with other portable apps (e.g. UnityHub). | Only one application can use PAL (*appinfo.ini* can only point to one launcher file when building the launcher, but you can build launchers with different *appinfo.ini* and put them in the same directory, the launcher will look for the launcher file with the same name as its file name) |
| Customize the application directory by modifying the value of the `UnityEditorDirectory` key in the `UnityEditorPortable` section of *UnityEditorPortable.ini* (the *UnityEditorPortable.ini* in the root directory, not the one in the *Launcher* directory). | So far, PAL does not natively provide a way for application users to configure the application directory. Although it is possible to customize the application directory by modifying the launcher file, that is not recommended (those files are for developers, not users). |
| Recognized by Unity Hub (by adding a `Unity Version` entry to the executable's version information) | Not recognized by Unity Hub |

### Native NSIS Unity Portable Launcher

#### Requirement
- NSIS
- *ProcFunc.nsh* (Get it from [PortableApps.com](https://portableapps.com/node/12561) or [GitHub](https://raw.githubusercontent.com/PortableApps/Launcher/master/Other/Source/Include/ProcFunc.nsh)).
- *ReplaceInFileWithTextReplace.nsh* (Get it from [GitHub](https://raw.githubusercontent.com/PortableApps/Launcher/master/Other/Source/Include/ReplaceInFileWithTextReplace.nsh)).
- *PortableApps.comLauncherLANG_ENGLISH.nsh* (Get it from [GitHub](https://raw.githubusercontent.com/PortableApps/AppConfigs/master/F/Firefox/Langs/PortableApps.comLauncherLANG_ENGLISH.nsh)).

## About Unity Editor
 ![](https://img.shields.io/badge/shareware-yellow)
 ![](https://img.shields.io/badge/proprietary-important)

### Identifier
 - `dk.otee.UnityEditor` (Unity 1.x)
 - `com.unity3d.UnityEditor` (Unity 2.x)
 - `com.unity3d.UnityEditor3.x` (Unity 3.x)
 - `com.unity3d.UnityEditor4.x` (Unity 4.x)
 - `com.unity3d.UnityEditor5.x` (Unity 5.x and later)

### Categories
 ![](https://img.shields.io/badge/Development-informational)

### Platforms
 - MacOS
 - Windows (version 2.5 and later)
 - Linux (version 2017.4.6 and later)

### Dependencies
- Visual C++ Redistributable
  - Microsoft Visual C++ 2010 Redistributable Package (Unity 5.x and later). [Download](https://www.microsoft.com/en-us/download/details.aspx?id=26999).
    - *MSVP100.dll*
    - *MSCR100.dll*
  - Visual C++ Redistributable Packages for Visual Studio 2013 (Unity 5.x and later). [Download](https://www.microsoft.com/en-my/download/details.aspx?id=40784).
    - *MSCP120.dll*
    - *MSCR120.dll*

- Unity Hub (mandatory for account authentication of Unity 2019 and above)

### Website
 - Official Website:
   - http://www.unity3d.com
   - http://otee.dk/unity.html (old)

### Developers
 Unity Technologies ApS.

### Trademarks
 "Unity", Unity logos, and other Unity trademarks are trademarks or registered trademarks of Unity Technologies or its affiliates in the U.S. and elsewhere ([more info here](https://unity.com/legal/trademarks)).
