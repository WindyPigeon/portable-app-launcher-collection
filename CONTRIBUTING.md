# Contributing guide

## How Can I Contribute?

### Reporting Bugs
 - Perform a [cursory search](https://github.com/search?q=+is%3Aissue+repo%3AWindyPigeon%2Fportable-app-launcher-collection). Check first if somebody else had already reported the issue.

 - Read [the GitHub documentation](https://docs.github.com/en/issues/tracking-your-work-with-issues/creating-an-issue) to learn how to report an issue. Follow the step to report yout issue. State the **application name**, **version** and **details** of the problem in the problem report.

### Code Contribution
 Clone this Git repository to your computer.
 You can use [GitHub Desktop](https://desktop.github.com/) to make your work easier.

 Each application should be modified in a **different branch**.
 This is for better management of this repository.

 Go to the branch where your application is located.

 For new application, Go to `new` branch.
 Create a new branch based on `new` branch.

 **Don't** make any change to `new` branch!! This branch is used as a template for new application branches.

 Make changes to the branch. Write the date, what was changed and your contact information in *CHANGELOG.md*. If this is your first time editing this branch, please add your name (or pseudonym) and contact details to the *AUTHOR.md* file so we can remember your contribution.

 Commit your code to the corresponding branch. Make sure to clearly describe your changes in your commit message.

 Every once in a while we'll merge your changes into the `main` branch.

## Styleguide
 Although we are based on the [PortableApps.com Format](https://portableapps.com/development/portableapps.com_format#:~:text=PortableApps.com%20Format%20is%20a,paf.exe%E2%84%A2%20installer%20files.), we have our own coding style and coding conventions that differ from [PortableApps.com](https://portableapps.com/).

### Folder stucture of portable app

  - *Data* directory is managed in Mac folder structure style.
    - In Windows and Linux, application data are classified into different directories such as *AppData\Roaming*, *AppData\Local*, *ProgramData*, *.config* etc. according to their user access rights.
    But this classification is meaningless for portable app where all the files in the *Data* directory belong to the same user.

      In Mac, application data is further classified into *Application Support*, *Caches*, *Logs*, *Preferences* etc. according to their functions.

    - If *Caches* files, *Logs* files or *Preferences* files are mixed with *Application Support* files, use PAL's *DirectoriesMove* to move the *Application Support* files. In the `PostPrimary` section of the custom code, rename or move the *Caches* files and *Logs* files collected in the *Data* directory to their corresponding paths.

      In general, we don't need to restore the *Logs* file before the software is executed, because most software will not open the previous logs. We only need to back up the logs for the user to the *Data* directory.

### Registry key
 - Name the saved registry key with the application's *BundleIdentifier* on the Mac.
   - Each saved Registration Entries file should correspond to a Property list file in the Mac *Preference* directory.
     If there is no such file, delete it as a garbage registry key.

     As an example, the `HKCU\Software\JavaSoft\Prefs` registry key in Windows corresponds to the `com.apple.java.util.prefs.plist` file in Mac.

   - This is for consistency with the *Preference* directory in Mac.

### Portablize approach
 - Some application developers provide various ways to customize certain paths of their application.
   In this case, the portablize method used is selected according to the following priorities:

   > 1. Configure the data path with configuration file.
   > 2. The data path cannot be customized.
        Backup and restore the file with `FilesMove` and `DirectoriesMove`
   > 3. Configure the data path with value of environment variable.
   > 4. Configure the data path in command-line arguments.
   > 5. The data path is determined by working directory.
        Configure the data path by set the `WorkingDirectory` to the *Data* directory.

  - Configuring the data path with configuration files has the highest priority because it avoid copying or moving large number of files, resulting in faster starting and closing.

  - Configuring the data path with environment variable and command-line arguments have the lowest priority. Some applications allow users to run new instances of the application without going through the launcher. We cannot guarantee that the environment variables and command-line parameters of the first application instance will be passed to the next instance.

### Language and locale configuration
 - `CheckIfExists` is only set if the application's language features depend on certain files.
   - Try to test that the language functions correctly in the absence of that file.

 - All languages officially supported by the application should be listed in `LanguageStrings` section.
   - The order of language sorting is based on the order presented by the software UI (e.g. drop-down list), instead of using alphabetical sorting.

### File extension associations
 - The order of file extensions is based on the content of *Info.plist* in the Mac application package.
 - FileTypeIcons:
   - If the file extension shares the same icon as the application, the file extension's icon will be set to `app`.
   - `AllOtherIcons` will used if all the other file extensions have same icon.

### AppInfo
 - The application software information in the *appinfo.ini* file will be based on the following information sources:
   - *appinfo.ini* file
     - `Details` section
       - The value of `Name` key =

         The value of the `Name` key in the `Desktop Entry` section of the Linux desktop entry file, with the "Portable" suffix added.

       - The value of `Publisher` key =

         The `Publisher` value in the `Uninstall` registry key (`HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall`) in Windows.

       - The value of `Homepage` key =

         A link to the home page of our portable app launcher, not to the app.

       - The value of `Category` key =

         Based on `LSApplicationCategoryType` key of *Info.plist* file in the Mac application package.

         `public.app-category.utilities` = `Utilities`

         `public.app-category.developer-tools` = `Development`

         `public.app-category.education` =
         `Education`

         `public.app-category.games`, `public.app-category.action-games`, `public.app-category.adventure-games`, `public.app-category.arcade-games`, `public.app-category.board-games`, `public.app-category.card-games`, `public.app-category.casino-games`, `public.app-category.dice-games`, `public.app-category.educational-games`, `public.app-category.family-games`,`public.app-category.kids-games`,`public.app-category.music-games`,`public.app-category.puzzle-games`,`public.app-category.racing-games`,`public.app-category.role-playing-games`,`public.app-category.simulation-games`,`public.app-category.sports-games`,`public.app-category.strategy-games`,`public.app-category.trivia-games`,`public.app-category.word-games` =
         `Games`

         `public.app-category.graphics-design`, `public.app-category.photography` =
         `Graphics & Pictures`

         `public.app-category.music`, `public.app-category.video` =
         `Music & Video`

       - The value of `Description` key =

         The value of the `GenericName` key in the `Desktop Entry` section of the Linux desktop entry file

   - *help.html* file
     - Catchy tag line =

       `summary` in the *.appdata.xml* file of the application in Linux

     - Description of app function =

       `description` in the *.appdata.xml* file of the application in Linux

     - Link to learn more about the application =
       The `URLInfoAbout` value in the `Uninstall` registry key (`HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall`) in Windows.
