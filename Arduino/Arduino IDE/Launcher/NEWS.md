# Arduino IDE Portable launcher NEWS

## Version 2.0.0
- The path of application executable file had change to `Arduino IDE\Arduino IDE.exe` under the *App* directory.
- `Data\Library\Application Support\arduino-pro-ide` directory is replaced by `Data\Library\Application Support\arduino-ide` directory. All files and directories in `%USERPROFILE%\AppData\Roaming\arduino-ide` will saved to `Data\Library\Application Support\arduino-ide`
- `Data\.arduinoProIDE` directory is replaced by `Data\.arduinoIDE` directory. All files and directories in `%USERPROFILE%\.arduinoIDE` will saved to `Data\.arduinoIDE`
- `Data\Library\Logs\Arduino Pro IDE` directory is replaced by `Data\Library\Logs\Arduino IDE` directory. All files and directories in `%USERPROFILE%\AppData\Roaming\Arduino IDE` will saved to `Data\Library\Logs\Arduino IDE`

## Version 0.0.6
- `Data\.theia` directory is replaced by `Data\.arduinoIDE` directory. All files and directories in `%USERPROFILE%\.arduinoProIDE` will saved to `Data\.arduinoProIDE`

## Version 0.0.3
- `Data\Library\Application Support\arduino.Pro.IDE` directory is replaced by `Data\Library\Application Support\arduino-pro-ide` directory. All files and directories in `%USERPROFILE%\AppData\Roaming\arduino-pro-ide` will saved to `Data\Library\Application Support\arduino-pro-ide`

## Version 0.0.2
- The path of application executable file had change to `Arduino Pro IDE\Arduino Pro IDE.exe` under the *App* directory.
- `Data\Library\Application Support\arduino-electron` directory is replaced by `Data\Library\Application Support\arduino.Pro.IDE` directory. All files and directories in `%USERPROFILE%\AppData\Roaming\arduino.Pro.IDE` will saved to `Data\Library\Application Support\arduino.Pro.IDE`
- `Data\Library\Logs\Arduino-PoC` directory is replaced by `Data\Library\Logs\Arduino Pro IDE` directory. All files and directories in `%USERPROFILE%\AppData\Roaming\Arduino Pro IDE` will saved to `Data\Library\Logs\Arduino Pro IDE`

## Version 0.0.1
- *Arduino-PoC\Arduino-PoC.exe* under the *App* directory is the executable file of the application.
- The Arduino-PoCPortable launcher save all files and directories in `%USERPROFILE%\AppData\Roaming\arduino-electron` directory to `Data\Library\Application Support\arduino-electron` directory.
- The Arduino-PoCPortable launcher save all files and directories in `%USERPROFILE%\AppData\Local\Arduino15` directory to `Data\Library\Arduino15` directory.
- The Arduino-PoCPortable launcher save all files and directories in `%USERPROFILE%\AppData\Roaming\Arduino-PoC` directory to `Data\Library\Logs\Arduino-PoC` directory.
- The Arduino-PoCPortable launcher save all files and directories in `%USERPROFILE%\.theia` directory to `Data\.theia` directory.
