# Natron Portable Launcher NEWS

## Version 2.0.0
- Add new registry key in `QtKeyCleanup`
  - `Qt Factory Cache 4.8\com.trolltech.Qt.QIconEngineFactoryInterface:`
  - `Qt Factory Cache 4.8\com.trolltech.Qt.QIconEngineFactoryInterfaceV2:`

- Save all files and directories in `%USERPROFILE%\AppData\Local\INRIA\Natron\cache\OFXLoadCache` directory to `Data\Library\Caches\INRIA\Natron\OFXLoadCache` directory.

## Version 1.0.0
- Customize the disk cache path (root of *DiskCache* and *ViewerCache* directory) to `Data\Library\Caches\INRIA\Natron` in the `HKEY_CURRENT_USER\Software\INRIA\Natron` registry key before running the application. The Launcher will create this directory before running the application.

## Earlier release
- Save the `HKEY_CURRENT_USER\Software\INRIA\Natron` registry key as ***com.inria.Natron.reg*** file

- Save `%USERPROFILE%\AppData\Local\INRIA\Natron\Autosaves` directory to `Data\Library\Application Support\INRIA\Natron\Autosaves`

- Save `%USERPROFILE%\AppData\Local\INRIA\Natron\cache\OFXCache.xml` file to `Data\Library\Caches\INRIA\Natron\` directory.

- Save all files and directories in `%USERPROFILE%\AppData\Local\INRIA\Natron\cache\DiskCache` directory to `Data\Library\Caches\Natron\DiskCache` directory.

- Save all files and directories in `%USERPROFILE%\AppData\Local\INRIA\Natron\cache\ViewerCache` directory to `Data\Library\Caches\Natron\ViewerCache` directory.
