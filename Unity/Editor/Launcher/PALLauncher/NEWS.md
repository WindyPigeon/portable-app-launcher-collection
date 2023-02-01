# Unity Portable PAL Launcher NEWS

## Version 2022.1.0
- The `.upmconfig.toml` will be saved to `Data` directory.

## Version 2020.1.0
- The `CoreBusinessMetrics.db`, `CoreBusinessMetrics.db-shm` and `CoreBusinessMetrics.db-wal` will be saved to `Data\Library\Application Support\Unity` directory.

## Version 5.0.0
- All files and directories in `%USERPROFILE%\AppData\Roaming\Unity\Certificates` directory will be saved to `Data\Library\Unity\Certificates` directory.

- All files and directories in `%USERPROFILE%\AppData\Roaming\Unity\Packages` directory will be saved to `Data\Library\Unity\Packages` directory.

- All files and directories in `$PROFILE\AppData\LocalLow\Unity\Editor` directory will be saved to `Data\Library\Application Support\Unity\Editor` directory (implemented using custom code).

-  When the application runs for the first time, `GI${ReplaceInFile} "$SETTINGSDIRECTORY\com.unity3d.UnityEditor5.x.reg"Folder` will be set to the `Data\Library\Caches\com.unity3d.UnityEditor\GiCache` directory by modifying the registry..

- All files and directories in `$PROFILE\AppData\LocalLow\Unity\Browser` directory will be saved to `Data\Library\Library\Unity\Browser` directory (implemented using custom code).

- The project directory (`kNewProjectsPath`) is initialized to `%PortableApps.comDocuments%\Unity Projects` when the app is first run.

## Version 4.0.0
- The license files is move to `%SystemDrive%\ProgramData\Unity`. *Unity_lic.ulf* and *Unity_lic.ulf.backup* in this directory will be saved to `Library\Application Support\Unity`.

## Version 2.5.0
- The `HKCU\Software\Unity Technologies\Unity Editor` registry key will be saved as `Data\settings\com.unity3d.UnityEditor.reg`

- The `HKCU\Software\Unity\Unity Editor` registry key will be appended to `Data\settings\com.unity3d.UnityEditor.reg` (implemented using custom code).

- All files and directories in `%USERPROFILE%\AppData\Roaming\PACE Anti-Piracy\License Files` directory will be saved to `Data\Library\Application Support\PACE Anti-Piracy\License Files`

- The log file (*Editor.log*) path will be set to `Data\Library\Logs\Unity\Editor.log` via a command line argument.
