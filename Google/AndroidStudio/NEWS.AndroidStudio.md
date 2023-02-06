# Android Studio NEWS

## Version 2020.3.1
 ![](https://img.shields.io/badge/release_date-july_2021-informational)

- New environment variable.
  - `ANDROID_USER_HOME`
    - Determine the root of the *avd* directory and the *debug.keystore* file.

## Version 4.1
 ![](https://img.shields.io/badge/release_date-august_2020-informational)

- New application icon.

  ![](Icons/AppIcon/4.1/appicon_128.png)

- The locations of the *config* directories, *system* directories, and *log* directories have been moved.
  - *config* directories:
    - Mac:
      `~\Library\Preferences\AndroidStudio<version>` ->
      `~\Library\Application Support\Google\AndroidStudio<version>`
    - Windows:
      `<SystemDrive>\Users\<USERNAME>\AndroidStudio<version>\config` ->
      `%APPDATA%\Google\AndroidStudio<version>`
  - *system* directories:
    - Mac:
      `~\Library\Caches\AndroidStudio<version>` ->
      `~\Library\Caches\Google\AndroidStudio<version>`
    - Windows:
      `<SystemDrive>\Users\<USERNAME>\AndroidStudio<version>\system` ->
      `%LOCALAPPDATA%\Google\AndroidStudio<version>`
  - *log* directories:
    - Mac:
      `~\Library\Logs\AndroidStudio<version>` ->
      `~\Library\Logs\Google\AndroidStudio<version>`
    - Windows:
      `<SystemDrive>\Users\<USERNAME>\AndroidStudio<version>\system\log` ->
      `%LOCALAPPDATA%\Google\AndroidStudio<version>\log`

## Version 3.6
 ![](https://img.shields.io/badge/release_date-february_2020-informational)

  - The default project directory started referring to the `defaultProjectDirectory` option in the *ide.general.xml* file instead of the `lastProjectLocation` in the *recentProjects.xml*.

## Version 3.3
 ![](https://img.shields.io/badge/release_date-january_2019-informational)

- New files and directory.
  - New options file *ide.general.xml*
    - Path:
      - Mac: 
        `~\Library\Preferences\AndroidStudio<version>\options\ide.general.xml`
      - In Windows:
        `<SystemDrive>\Users\<USERNAME>\AndroidStudio<version>\config\options\ide.general.xml`
    - The default directory for project opening is saved in this file.
      - The `value` attribute of the node whose XPath is:
        ```
        /application/component[@name="GeneralSettings"]/option[@name="defaultProjectDirectory"]
        ```
      - This directory has not replaced the *lastProjectLocation* directory in *recentProjects.xml*.
  - A new directory is used to save the user's consent options.
    - Path:
      - Mac: `~\Library\Application Support\Google\consentOptions`
      - Windows: `%APPDATA%\Google\consentOptions`
    - If the user has accepted the consent, the user's consent options will be saved as an *accepted* file.

## Version 3.0
 ![](https://img.shields.io/badge/release_date-october_2017-informational)


- Change of registry keys / property list files:
  - The `/Jet/Brains./User/Id/On/Machine` value of the `HKEY_CURRENT_USER\Software\JavaSoft\Prefs`registry key and `JetBrains.UserIdOnMachine` key in *com.apple.java.util.prefs.plist* property list file is deprecated.
  - The parent of `user_id_on_machine` registry key value and property list key had been changed from `jetbrains` to `google`

## Earlier version
  ![](Icons/AppIcon/2.0/appicon_128.png)

- The default directory of the Android SDK folder can be customized.
  - Option 1: Customize Android SDK directory with *jdk.table.xml* file
    - The content of the file is written in XML format.
    - The path of *jdk.table.xml*:
      - In Mac:
        `~\Library\Preferences\AndroidStudio<version>\options\jdk.table.xml`
      - In Windows:
        `<SystemDrive>\Users\<USERNAME>\AndroidStudio<version>\config\options\jdk.table.xml`
    - The XPath of the default directory of the Android SDK folder saved in *jdk.table.xml* is:
      ```
      /application/component[@name="ProjectJdkTable"]/jdk[@version="2"][child::name[@value]][child::type[@value="Android SDK"]][child::roots]/homePath
      ```
      - The `version` attribute of the `jdk` node is necessary.
      - The `value` attribute of the `name` node can be an empty string but cannot be missing.
      - A `type` node with `value="Android SDK"` attribute is required.
      - The content of the `roots` node can be empty, but the `roots` node cannot be missing.
      - This directory will only be used if it already exists.
  - Option 2: Customize Android SDK directory with `ANDROID_HOME` environment variable.
  - Priority (higher priority > lower priority):
    `ANDROID_HOME` > *jdk.table.xml*

- The default directory of the project folder is saved in *recentProjects.xml*.
  - The content of the file is written in XML format.
  - The path of *recentProjects.xml*
    - In Mac:
      `~\Library\Preferences\AndroidStudio<version>\options\recentProjects.xml`
    - In Windows:
      `<SystemDrive>\Users\<USERNAME>\AndroidStudio<version>\config\options\recentProjects.xml`
  - The XPath of the default directory of the project folder saved in *recentProjects.xml* is:
    ```
    /application/component[@name="RecentProjectsManager"]/option[@name="lastProjectLocation"]
    ```
  - The existence of the directory is not necessary.

- Registry keys / property list files:
  - *com.apple.java.util.prefs*
    - Path:
      - Mac: `~/Library/Preferences/com.apple.java.util.prefs.plist` 
      - Windows (registry key): `HKEY_CURRENT_USER\Software\JavaSoft\Prefs`
    - Subkeys and values:
      - `JetBrains.UserIdOnMachine`
        - XPath saved in *com.apple.java.util.prefs.plist*:
          ```
          //plist/dict/key["/"]/following-sibling::dict/key["JetBrains.UserIdOnMachine"]/following-sibling::string/text()
          ```
        - It is saved in the `/Jet/Brains./User/Id/On/Machine` value of the `HKEY_CURRENT_USER\Software\JavaSoft\Prefs` registry key.
      - `user_id_on_machine`
        - XPath saved in *com.apple.java.util.prefs.plist*:
          ```
          //plist/dict/key["/"]/following-sibling::dict/key["jetbrains/"]/following-sibling::dict/key["user_id_on_machine"]/following-sibling::string/text()
          ```
        - It is saved in the `user_id_on_machine` value of the `HKEY_CURRENT_USER\Software\JavaSoft\Prefs\jetbrains` registry key.
    - *com.google.gct*
      - Path:
        - Mac: `~/Library/Preferences/com.google.gct.plist`
        - Windows (registry key): `HKEY_CURRENT_USER\Software\JavaSoft\Prefs\com\google\gct` 
      - Subkeys and values:
        - `login` (subkey)
          - XPath saved in *com.google.gct.plist*
            ```
            //plist/dict/key["/com/google/gct/"]/following-sibling::dict/key["login/"]/following-sibling::dict
            ```
          - It is saved as the `login` subkey of the `HKEY_CURRENT_USER\Software\JavaSoft\Prefs\com\google\gct` registry key.
