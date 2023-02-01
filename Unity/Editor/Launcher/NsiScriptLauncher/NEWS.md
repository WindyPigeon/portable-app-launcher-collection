## Unity Editor Portable (NSI Script Launcher) NEWS

## Version 2019.1.0
- Add an options page so the user can choose to run the app to create a project or open a project. The user will select the project directory on the directory page. All of this is implemented using NSIS's installer pages and MUI. The launcher will create or open the project with parameters so that Unity's options page can be skipped. The reason why Unity's original option page is not used, but the custom page is rewritten is to allow the launcher to obtain the target project path. The launcher can read the company name and product name of the project through the project path, so that the launcher can clean up the data left by the project in the locallow directory and the registry.

## Version 5.0.0
- The `$PROFILE\LocalLow\<companyname>\<productname>` will be created by Unity when opening or creating a project

## Version 5.0.0
- `$PROFILE\LocalLow\<companyname>\<productname>` will be created by Unity when opening or creating a project, but the launcher will not clean them up. In order to accurately locate and clean them, the launcher needs to know the company name and product name information of the target project stored in `ProjectSettings.asset`, so far we don't know how to do this.

## Version 4.0.0
- **Bugs**
  - It may be necessary to run as administrator to successfully complete account authentication. This is a bug with the Unity app, not the launcher.

## Version 2.5.0
- In the version information of the launcher, `CompanyName` is set to `Unity Technologies ApS`, and `Unity Version` custom information is added, so that when the launcher executable file is renamed to `Unity.exe`, it can be recognized by Unity Hub.

- To allow the launcher to be renamed to `Unity.exe` so that it is recognized by the Unity Hub, the launcher will work even if it is renamed to have the same name as its application executable. In addition to the executable file name, the launcher also checks the path of the process executable file to avoid confusion with the launcher's executable file name.

- The launcher checks the version number of the application executable to ensure it matches the launcher version before the application runs.

- Keep the RunLocally feature, so that the app will run properly even when it is stored on read-only storage (such as a CD-ROM).

- The application directory, application executable file, and data file directory can be customized through the `UnityEditor<MajorVersion>.xPortable.ini` file.

- Unity verifies whether the folder is a project folder by checking whether the `Assets` directory exists under the folder directory.
