# Unity Hub NEWS

## Version 3.0.0
 ![](https://img.shields.io/badge/release_date-january_2022-informational)

 View the [release notes](https://unity.com/unity-hub/release-notes#300).

- New application icon.

  ![](IconFiles/AppIcon/3.0.0/appicon_32.png)

- The app no longer has an account authentication UI. Account authentication will be done in the browser. In order for account authentication to work, the unity URL type must be associated.
- The path to the license file (*Unity_lic.ulf*) is determined by `SystemDrive` environment variable instead of `ProgramData` environment variable.

## Version 2.4.0
 ![](https://img.shields.io/badge/release_date-september_2020-informational)

 View the [release notes](https://unity.com/unity-hub/release-notes#240).

- Distribution:
  - Download archive:
    - Windows 64-bit: [UnityHubSetup.exe](https://web.archive.org/web/20200919080617/https://public-cdn.cloud.unity3d.com/hub/prod/UnityHubSetup.exe)

- New application icon.

  ![](IconFiles/AppIcon/2.4.0/appicon_32.png)

## Version 2.3.1
 ![](https://img.shields.io/badge/release_date-april_2020-informational)

 View the [release notes](https://unity.com/unity-hub/release-notes#231).

- Distribution:
  - Download archive:
    - Windows 64-bit: [UnityHubSetup.exe](https://web.archive.org/web/20200509094524/https://public-cdn.cloud.unity3d.com/hub/prod/UnityHubSetup.exe)

- Plugins directory:
  - MacOS: `~/Library/UnityHub/Plugins`
  - Windows: `%APPDATA%\UnityHub\Plugins`

## Version 2.3.0
 ![](https://img.shields.io/badge/release_date-march_2020-informational)

 View the [release notes](https://unity.com/unity-hub/release-notes#230).

- Distribution:
  - Download archive:
    - Windows 64-bit: [UnityHubSetup.exe](https://web.archive.org/web/20200328132255/https://public-cdn.cloud.unity3d.com/hub/prod/UnityHubSetup.exe)

- New application icon.

  ![](IconFiles/AppIcon/2.3.0/appicon_32.png)

## Version 2.1.1
 ![](https://img.shields.io/badge/release_date-september_2019-informational)

 View the [release notes](https://unity.com/unity-hub/release-notes#211).

- Option to switch language in the hub and in the new user on-boarding flow
  - The application language configuration is stored as the value of the `directoryPath` key in *languageConfig.json*.

## Version 2.0.0
 ![](https://img.shields.io/badge/release_date-may_2019-informational)

 View the [release notes](https://unity.com/unity-hub/release-notes#200).

- Distribution:
  - Download archive:
    - MacOS: [UnityHubSetup.dmg](https://web.archive.org/web/20190522204701/https://public-cdn.cloud.unity3d.com/hub/prod/UnityHubSetup.dmg)
    - Windows 64-bit: [UnityHubSetup.exe](https://web.archive.org/web/20190522204701/https://public-cdn.cloud.unity3d.com/hub/prod/UnityHubSetup.exe)

## Version 1.6.0
 ![](https://img.shields.io/badge/release_date-march_2019-informational)

 View the [release notes](https://unity.com/unity-hub/release-notes#160).

- Distribution:
  - Download archive:
    - Windows 64-bit: [UnityHubSetup.exe](https://web.archive.org/web/20190323230758/https://public-cdn.cloud.unity3d.com/hub/prod/UnityHubSetup.exe)
    - MacOS: [UnityHubSetup.dmg](https://web.archive.org/web/20190323225958/https://public-cdn.cloud.unity3d.com/hub/prod/UnityHubSetup.dmg)

## Version 1.0.0
 ![](https://img.shields.io/badge/release_date-2018-informational)


- Distribution:
  - Download archive:
    - Windows 64-bit: [UnityHubSetup.exe](https://web.archive.org/web/20180930040444/https://public-cdn.cloud.unity3d.com/hub/prod/UnityHubSetup.exe)
    - MacOS: [UnityHubSetup.dmg](https://web.archive.org/web/20180930040444/https://public-cdn.cloud.unity3d.com/hub/prod/UnityHubSetup.dmg)

- Application icon:

  ![](IconFiles/AppIcon/1.0.0/appicon_32.png)

- Unity Hub will automatically search for all `<secondaryInstallPath>\Editor\<UnityVersion>\Editor\Unity.exe` executables as installed Unity.

- Unity Hub recognizes Unity application executables by recognizing the "Unity Version" and "CompanyName" in the version information. `Unity Version` must contain a version number in the format `<Major>.<Minor>.<Release><Letter><Revision>` (letter "a" for alpha, letter "b" for beta, letter "f" finally , in order to determine which templates are available for a version, the version must actually exist, the revision number can be zero, allowing a suffix after the version number, eg "5.0.0f0Portable") and the `CompanyName` must be `Unity Technologies ApS`. The file name must be `Unity.exe`.
