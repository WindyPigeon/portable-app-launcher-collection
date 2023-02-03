!addplugindir /x86-unicode ".\Plugins"

!ifndef VER_MAJOR
    !define VER_MAJOR "2"
!endif

!ifndef VER_MINOR
    !define VER_MINOR "0"
!endif

!ifndef VER_RELEASE
    !define VER_RELEASE "0"
!endif

!ifndef VER_RELEASETYPE
    !define VER_RELEASETYPE "f"
!endif

!ifndef VER_REVISION
    !define VER_REVISION "0"
!endif

!ifndef UNITYVERSION
    !define UNITYVERSION "${VER_MAJOR}.${VER_MINOR}.${VER_RELEASE}${VER_RELEASETYPE}${VER_REVISION}"
!endif

!define PORTABLEAPPNAME "Unity Portable"
!define NamePortable "Unity Portable"
!define APPNAME "Unity"
!define NAME "UnityEditor${VER_MAJOR}.xPortable"
!define AppID "UnityEditorPortable"
!define VER "${VER_MAJOR}.${VER_MINOR}.${VER_RELEASE}.${VER_REVISION}"
!define WEBSITE "github.com/WindyPigeon/portable-app-launcher-collection"
!define DEFAULTEXE "Unity.exe"
!define DEFAULTAPPDIR "Unity\Editor"
!define LAUNCHERLANGUAGE "English"

;=== Program Details
Name "${PORTABLEAPPNAME}"
OutFile "..\..\${NAME}.exe"
Caption "${PORTABLEAPPNAME} | WindyPigeon"
VIProductVersion "${VER}"
VIAddVersionKey ProductName "${PORTABLEAPPNAME}"
VIAddVersionKey Comments "Allows ${APPNAME} to be run from a removable drive. For additional details, visit ${WEBSITE}"
VIAddVersionKey CompanyName "Unity Technologies ApS"
VIAddVersionKey LegalCopyright "WindyPigeon"
VIAddVersionKey FileDescription "${PORTABLEAPPNAME}"
VIAddVersionKey FileVersion "${VER}"
VIAddVersionKey ProductVersion "${VER}"
VIAddVersionKey InternalName "${PORTABLEAPPNAME}"
VIAddVersionKey LegalTrademarks '"Unity", Unity logos, and other Unity trademarks are trademarks or registered trademarks of Unity Technologies or its affiliates in the U.S. and elsewhere.'
VIAddVersionKey OriginalFilename "${NAME}.exe"
;VIAddVersionKey PrivateBuild ""
;VIAddVersionKey SpecialBuild ""
VIAddVersionKey "Unity Version" "${UNITYVERSION} Portable"

;=== Runtime Switches
CRCCheck On
WindowIcon Off
SilentInstall Silent
AutoCloseWindow True
RequestExecutionLevel user
XPStyle on
Unicode true
ManifestDPIAware true

; Best Compression
SetCompress Auto
SetCompressor /SOLID lzma
SetCompressorDictSize 32
SetDatablockOptimize On

;=== Include
;(Standard NSIS)
!include FileFunc.nsh
!insertmacro GetParameters ;Requires NSIS 2.40 or better
!include LogicLib.nsh
!include Registry.nsh
!include TextFunc.nsh
!insertmacro GetParent
!include WinVer.nsh
!include WordFunc.nsh
!insertmacro VersionCompare

;(NSIS Plugins)
!include TextReplace.nsh

;(Custom)
!include ProcFunc.nsh
!include ReplaceInFileWithTextReplace.nsh

;=== Program Icon
Icon "..\..\App\AppInfo\appicon.ico"
; Icon "..\..\App\AppInfo\appicon_1.ico"

;=== Icon & Stye ===
BrandingText "WindyPigeon"

;=== Languages
LoadLanguageFile "${NSISDIR}\Contrib\Language files\${LAUNCHERLANGUAGE}.nlf"
!include PortableApps.comLauncherLANG_${LAUNCHERLANGUAGE}.nsh

;=== Variables
Var PROGRAMDIRECTORY
Var SETTINGSDIRECTORY
Var ADDITIONALPARAMETERS
Var EXECSTRING
Var PROGRAMEXECUTABLE
Var INIPATH
Var DISABLESPLASHSCREEN
Var LASTDRIVE
Var CURRENTDRIVE
Var DATADIRECTORY
Var LASTDIRECTORY
Var CURRENTDIRECTORY
Var LASTPORTABLEAPPSBASEDIRECTORY
Var PORTABLEAPPSBASEDIRECTORY
Var PACEAPDATADIRECTORY
Var RUNLOCALLY
Var MISSINGFILEORPATH

Section "Main"
    ;=== Find the INI file, if there is one
    IfFileExists "$EXEDIR\${NAME}.ini" "" NoINI
        StrCpy $INIPATH "$EXEDIR"

    ;ReadINI:
        ;=== Read the parameters from the INI file
        ClearErrors
        ReadINIStr $0 "$INIPATH\${NAME}.ini" "${NAME}" "${APPNAME}Directory"
        ${If} ${Errors}
        ${OrIf} $0 == ""
            StrCpy $0 "App\${DEFAULTAPPDIR}"
        ${EndIf}
        StrCpy $PROGRAMDIRECTORY "$EXEDIR\$0"

        ClearErrors
        ReadINIStr $0 "$INIPATH\${NAME}.ini" "${NAME}" "${APPNAME}Executable"
        ${If} ${Errors}
        ${OrIf} $0 == ""
            StrCpy $0 "${DEFAULTEXE}"
        ${EndIf}
        StrCpy $PROGRAMEXECUTABLE "$0"

        ClearErrors
        ReadINIStr $0 "$INIPATH\${NAME}.ini" "${NAME}" "SettingsDirectory"
        ${If} ${Errors}
        ${OrIf} $0 == ""
            StrCpy $0 "Data\settings"
        ${EndIf}
        StrCpy $SETTINGSDIRECTORY "$EXEDIR\$0"

        ClearErrors
        ReadINIStr $0 "$INIPATH\${NAME}.ini" "${NAME}" "DataDirectory"
        ${If} ${Errors}
        ${OrIf} $0 == ""
            StrCpy $0 "Data"
        ${EndIf}
        StrCpy $DATADIRECTORY "$EXEDIR\$0"

        ReadINIStr $ADDITIONALPARAMETERS "$INIPATH\${NAME}.ini" "${NAME}" "AdditionalParameters"

        ClearErrors
        ReadINIStr $DISABLESPLASHSCREEN "$INIPATH\${NAME}.ini" "${NAME}" "DisableSplashScreen"
        ${If} ${Errors}
        ${OrIf} $DISABLESPLASHSCREEN == ""
            StrCpy $DISABLESPLASHSCREEN false
        ${EndIf}

        ClearErrors
        ReadINIStr $RUNLOCALLY "$INIPATH\${NAME}.ini" "${NAME}" "RunLocally"
        ${If} ${Errors}
        ${OrIf} $RUNLOCALLY == ""
            StrCpy $RUNLOCALLY false
        ${EndIf}

    ; EndINI:
        IfFileExists "$PROGRAMDIRECTORY\$PROGRAMEXECUTABLE" FoundProgramEXE NoProgramEXE

    NoINI:
        ;=== No INI file, so we'll use the defaults
        StrCpy $ADDITIONALPARAMETERS ""
        StrCpy $PROGRAMEXECUTABLE "${DEFAULTEXE}"
        StrCpy $DISABLESPLASHSCREEN "false"

        ${If} ${FileExists} "$EXEDIR\App\${DEFAULTAPPDIR}\${DEFAULTEXE}"
            StrCpy $PROGRAMDIRECTORY "$EXEDIR\App\${DEFAULTAPPDIR}"
            StrCpy $DATADIRECTORY "$EXEDIR\Data"
            StrCpy $SETTINGSDIRECTORY "$EXEDIR\Data\settings"
        ${ElseIf} ${FileExists} "$EXEDIR\Editor\${DEFAULTEXE}"
            StrCpy $PROGRAMDIRECTORY "$EXEDIR\Editor"
            SetOutPath "$EXEDIR\Editor"
            ${GetParent} "$EXEDIR" $0
            ${GetBaseName} "$0" $1
            ${DoUntil} $0 == ""
                ${GetParent} "$0" $0
                ${GetBaseName} "$0" $1
                ${If} $1 == "App"
                    ${GetParent} "$0" $0
                    StrCpy $DATADIRECTORY "$0\Data"
                    StrCpy $SETTINGSDIRECTORY "$0\Data\settings"
                    ${ExitDo}
                ${EndIf}
            ${Loop}
            ${If} $DATADIRECTORY == ""
                StrCpy $DATADIRECTORY "$EXEDIR\${AppId}Data"
                StrCpy $SETTINGSDIRECTORY "$EXEDIR\${AppID}Data\settings"
            ${EndIf}
        ${Else}
            Goto NoProgramEXE
        ${EndIf}

        Goto FoundProgramEXE

    NoProgramEXE:
        ;=== Program executable not where expected
        StrCpy $MISSINGFILEORPATH $PROGRAMEXECUTABLE
        MessageBox MB_OK|MB_ICONEXCLAMATION `$(LauncherFileNotFound)`
        Abort

    FoundProgramEXE:
        IntOp $0 ${VER_MAJOR} + 1
        ${GetFileVersion} "$PROGRAMDIRECTORY\$PROGRAMEXECUTABLE" $1
        ${VersionCompare} "$1" "${VER_MAJOR}.0.0.0" $2
        ${VersionCompare} "$1" "$0.0.0.0" $3
        ${If} $2 == 3
        ${OrIf} $3 != 2
            MessageBox MB_OK|MB_ICONEXCLAMATION `The version number of $PROGRAMDIRECTORY\$PROGRAMEXECUTABLE is $1. It's not Unity ${VER_MAJOR}.x.`
            Abort
        ${EndIf}

    ; CheckIfRunning:
        ;=== Check if running
        ;=== Create a mutex so we can determine if this specific launcher is already running
        System::Call 'kernel32::CreateMutex(i0,i0,t"${NAME}-$PROGRAMEXECUTABLE")?e'
        Pop $0

        ${IfNot} $0 = 0
            MessageBox MB_OK|MB_ICONSTOP `$(LauncherAlreadyRunning)`
            Quit
        ${EndIf}

        ${GetProcessPath} "Unity.exe" $0
        ${If} $0 != -1
        ${AndIf} $0 != 0
        ${AndIf} $0 != "$EXEDIR\$EXEFILE"
            MessageBox MB_OK|MB_ICONSTOP `$(LauncherAlreadyRunning)`
            Quit
        ${EndIf}

        ;=== Check for read/write
        ClearErrors
        CreateDirectory $SETTINGSDIRECTORY
        FileOpen $0 "$SETTINGSDIRECTORY\writetest.temp" w
        IfErrors "" WriteSuccessful
            ;== Write failed, so we're read-only
            MessageBox MB_YESNO|MB_ICONQUESTION `$(LauncherAskCopyLocal)` IDYES SwitchToRunLocally
            MessageBox MB_OK|MB_ICONINFORMATION `$(LauncherNoReadOnly)`
            Abort

    SwitchToRunLocally:
        StrCpy $RUNLOCALLY "true"
        ;=== Run locally if needed (aka Live)
        RMDir /r "$TEMP\${NAME}\"
        ${If} $RUNLOCALLY == true
            CreateDirectory "$TEMP\${NAME}Live\App\Unity\Editor"
            StrCpy $PROGRAMDIRECTORY "$TEMP\${NAME}Live\App\Unity\Editor"
            CopyFiles /SILENT "$PROGRAMDIRECTORY\*.*" "$TEMP\${NAME}Live\App\Unity\Editor"

            CreateDirectory "$TEMP\${NAME}Live\Data\Library"
            StrCpy $DATADIRECTORY "$TEMP\${NAME}Live\Data\Library"
            CopyFiles /SILENT "$DATADIRECTORY\Library\*.*" "$TEMP\${NAME}Live\Data\Library"

            CreateDirectory "$TEMP\${NAME}Live\Data\settings"
            StrCpy $SETTINGSDIRECTORY "$TEMP\${NAME}Live\Data\settings"
            CopyFiles /SILENT "$SETTINGSDIRECTORY\*.*" "$TEMP\${NAME}Live\Data\settings"
        ${EndIf}

    WriteSuccessful:

    ; CopyDefaultData:
        ;=== Check for data files
        ${IfNot} ${FileExists} "$DATADIRECTORY\Library\*.*"
        ${AndIfNot} ${FileExists} "$SETTINGSDIRECTORY\${AppID}Settings.ini"
            CreateDirectory "$DATADIRECTORY"
            ${If} ${FileExists} "$EXEDIR\App\DefaultData\*.*"
                CopyFiles /SILENT "$EXEDIR\App\DefaultData\*.*" "$DATADIRECTORY"
            ${EndIf}
        ${EndIf}

    ; CheckSettings:
        ${IfNot} ${FileExists} "$SETTINGSDIRECTORY\${AppID}Settings.ini"
            ;=== Create the default settings directory
            CreateDirectory $SETTINGSDIRECTORY

            ;=== Create the default settings file
            FileOpen $0 "$SETTINGSDIRECTORY\${AppID}Settings.ini" w
            FileClose $0
        ${EndIf}

    ; AdjustPaths:
        ReadINIStr $LASTDRIVE "$SETTINGSDIRECTORY\${AppID}Settings.ini" "${NAME}Settings" "LastDrive"
        ${GetRoot} $EXEDIR $CURRENTDRIVE
        WriteINIStr "$SETTINGSDIRECTORY\${AppID}Settings.ini" "${NAME}Settings" "LastDrive" $CURRENTDRIVE

        ${GetRoot} $EXEDIR $0
        StrLen $0 $0
        StrCpy $CURRENTDIRECTORY $EXEDIR "" $0
        ${If} $CURRENTDIRECTORY == ""
            StrCpy $CURRENTDIRECTORY "\"
        ${EndIf}
        ReadINIStr $LASTDIRECTORY "$EXEDIR\Data\settings\${AppID}Settings.ini" "${NAME}Settings" "LastDirectory"
        ${If} $CURRENTDIRECTORY != $LASTDIRECTORY
            WriteINIStr "$EXEDIR\Data\settings\${AppID}Settings.ini" "${NAME}Settings" "LastDirectory" $1
        ${EndIf}

        ${GetParent} $EXEDIR $0
        ${GetParent} $0 $PORTABLEAPPSBASEDIRECTORY
        ReadINIStr $LASTPORTABLEAPPSBASEDIRECTORY "$EXEDIR\Data\settings\${AppID}Settings.ini" "LastRunEnvironment" "LastPortableAppsBaseDir"
        ${If} $LASTPORTABLEAPPSBASEDIRECTORY != $PORTABLEAPPSBASEDIRECTORY
            WriteINIStr "$EXEDIR\Data\settings\${AppID}Settings.ini" "LastRunEnvironment" "LastPortableAppsBaseDir" $PORTABLEAPPSBASEDIRECTORY
        ${EndIf}

        ${If} ${FileExists} "$SETTINGSDIRECTORY\com.unity3d.UnityEditor.reg"
            ${If} $LASTDIRECTORY != ""
            ${AndIf} $LASTDIRECTORY != $CURRENTDIRECTORY
                ${ReplaceInFile} "$SETTINGSDIRECTORY\com.unity3d.UnityEditor.reg" "$LASTDRIVE/$LASTDIRECTORY" "$EXEDIR"
            ${EndIf}

            ${If} $LASTPORTABLEAPPSBASEDIRECTORY != ""
            ${AndIf} $LASTPORTABLEAPPSBASEDIRECTORY != $PORTABLEAPPSBASEDIRECTORY
                ${ReplaceInFile} "$SETTINGSDIRECTORY\com.unity3d.UnityEditor.reg" "$LASTDRIVE/$LASTPORTABLEAPPSBASEDIRECTORY" "$CURRENTDRIVE/$PORTABLEAPPSBASEDIRECTORY"
            ${EndIf}

            ${If} $LASTDRIVE != ""
            ${AndIf} $LASTDRIVE != $CURRENTDRIVE
                ${ReplaceInFile} "$SETTINGSDIRECTORY\com.unity3d.UnityEditor.reg" "$LASTDRIVE/" "$CURRENTDRIVE/"
            ${EndIf}
        ${EndIf}

    ; BackupOriginalData:
        ;=== Backup original app data
        ;=== Backup original editor preferences
        Rename "$APPDATA\Unity\Editor\Preferences" "$APPDATA\Unity\Editor\Preferences.BackupBy${NAME}"

        ;=== Backup original licenses
        Rename "$APPDATA\PACE Anti-Piracy" "$APPDATA\PACE Anti-Piracy.BackupBy${NAME}"
        Rename "$LOCALAPPDATA\PACE Anti-Piracy" "$LOCALAPPDATA\PACE Anti-Piracy.BackupBy${NAME}"
        Rename "$COMMONPROGRAMDATA\PACE Anti-Piracy" "$PACEAPDATADIRECTORY\PACE Anti-Piracy.BackupBy${NAME}"
        ${If} ${AtLeastWinVista}
            Rename "$PROFILE\AppData\Local\VirtualStore\Program Files (x86)\Common Files\PACE Anti-Piracy" "$PROFILE\AppData\Local\VirtualStore\Program Files (x86)\Common Files\PACE Anti-Piracy.BackupBy${NAME}"
        ${Else}
            Rename "$COMMONFILES\PACE Anti-Piracy" "$COMMONFILES\PACE Anti-Piracy.BackupBy${NAME}"
        ${EndIf}

    ; RestoreData:
        ;=== Restore the license
        ${If} ${FileExists} "$COMMONPROGRAMDATA"
            StrCpy $PACEAPDATADIRECTORY "$COMMONPROGRAMDATA"
        ${ElseIf} ${FileExists} "$APPDATA"
            StrCpy $PACEAPDATADIRECTORY "$APPDATA"
        ${ElseIf} ${AtLeastWinVista}
            StrCpy $PACEAPDATADIRECTORY "$PROFILE\AppData\Local\VirtualStore\Program Files (x86)\Common Files"
        ${Else}
            StrCpy $PACEAPDATADIRECTORY "$COMMONFILES"
        ${EndIf}
        ${GetRoot} "$DATADIRECTORY\Library\Application Support\PACE Anti-Piracy\License Files"  $0
        ${GetRoot} "$PACEAPDATADIRECTORY\PACE Anti-Piracy\License Files" $1
        ${If} $0 == $1
            Rename "$DATADIRECTORY\Library\Application Support\PACE Anti-Piracy\License Files" "$PACEAPDATADIRECTORY\PACE Anti-Piracy\License Files"
        ${Else}
            CreateDirectory "$PACEAPDATADIRECTORY\PACE Anti-Piracy\License Files"
            CopyFiles /SILENT "$DATADIRECTORY\Library\Application Support\PACE Anti-Piracy\License Files\*.*" "$PACEAPDATADIRECTORY\PACE Anti-Piracy\License Files"
        ${EndIf}

        ;=== Rename the previous Editor.log to Editor-prev.log
        Delete "$DATADIRECTORY\Library\Logs\Unity\Editor-prev.log"
        Rename "$DATADIRECTORY\Library\Logs\Unity\Editor.log" "$DATADIRECTORY\Library\Logs\Unity\Editor-prev.log"

        ;=== Restore the editor preferences
        ${GetRoot} "$DATADIRECTORY\Library\Preferences\Unity\Editor" $0
        ${GetRoot} "$APPDATA\Unity\Editor\Preferences" $1
        ${If} $0 == $1
            Rename "$DATADIRECTORY\Library\Preferences\Unity\Editor" "$APPDATA\Unity\Editor\Preferences"
        ${Else}
            CreateDirectory "$APPDATA\Unity\Editor\Preferences"
            CopyFiles /SILENT "$DATADIRECTORY\Library\Preferences\Unity\Editor\*.*" "$APPDATA\Unity\Editor\Preferences"
        ${EndIf}

    ; RegistryBackup:
        ;=== Backup the registry
        ${registry::KeyExists} "HKEY_CURRENT_USER\Software\Unity\UnityEditor" $0
        ${If} $0 != -1
            ${registry::MoveKey} "HKEY_CURRENT_USER\Software\Unity\UnityEditor" "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\Unity\UnityEditor" $0
        ${EndIf}

        ${registry::KeyExists} "HKEY_CURRENT_USER\Software\Unity Technologies\Unity Editor" $0
        ${If} $0 != -1
            ${registry::MoveKey} "HKEY_CURRENT_USER\Software\Unity Technologies\Unity Editor" "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\Unity Technologies\Unity Editor" $0
        ${EndIf}
        
        ${registry::KeyExists} "HKEY_CURRENT_USER\Software\PACE Anti-Piracy\InterLok\Reg" $0
        ${If} $0 != -1
            ${registry::MoveKey} "HKEY_CURRENT_USER\Software\PACE Anti-Piracy\InterLok\Reg" "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\PACE Anti-Piracy\InterLok\Reg" $0
        ${EndIf}

    ; RestoreTheKey:
        ${registry::RestoreKey} "$SETTINGSDIRECTORY\com.unity3d.UnityEditor.reg" $0

    ; DisplaySplash:
        StrCmp $DISABLESPLASHSCREEN "true" SkipSplashScreen
            ; === Show the splash screen before processing the files
            InitPluginsDir
            newadvsplash::show /NOUNLOAD 2000 0 0 -1 /L "$EXEDIR\App\AppInfo\Launcher\splash.jpg"

    SkipSplashScreen:
        ;=== Create ExecString
        StrCpy $EXECSTRING `"$PROGRAMDIRECTORY\$PROGRAMEXECUTABLE" -logfile "$DATADIRECTORY\Library\Logs\Unity\Editor.log"`

    ; GetPassedParameters:
        ;=== Get any passed parameters
        ${GetParameters} $0
        ${If} $0 != ""
            StrCpy $EXECSTRING "$EXECSTRING $0"
        ${EndIf}

    ; AdditionalParameters:
        ;=== Additional Parameters
        ${If} $ADDITIONALPARAMETERS != ""
            StrCpy $EXECSTRING "$EXECSTRING $ADDITIONALPARAMETERS"
        ${EndIf}

    ; LaunchNow:
        ExecWait "$EXECSTRING"

    CheckRunning:
        ${GetProcessPath} "$PROGRAMEXECUTABLE" $0
        ${If} ${ProcessExists} "$PROGRAMEXECUTABLE"
        ${AndIf} $0 != "$EXEDIR\$EXEFILE"
            ${ProcessWaitClose} "$PROGRAMEXECUTABLE" -1 $0
            Sleep 2000
            Goto CheckRunning
        ${EndIf}

    ; SaveRegistry:
        ${registry::SaveKey} "HKEY_CURRENT_USER\Software\Unity Technologies\Unity Editor" "$SETTINGSDIRECTORY\com.unity3d.UnityEditor.reg" "" $0
        ${registry::SaveKey} "HKEY_CURRENT_USER\Software\Unity\UnityEditor" "$SETTINGSDIRECTORY\com.unity3d.UnityEditor.reg" "/A=1 /G=0" $0

        CreateDirectory "$SETTINGSDIRECTORY\Authorization Preferences\Registration"
        ${registry::SaveKey} "HKEY_CURRENT_USER\Software\PACE Anti-Piracy\InterLok\Reg\Common" "$SETTINGSDIRECTORY\Authorization Preferences\Registration\PACE Common.reg" "" $0

    ; CleanupRegistry:
        ${registry::DeleteKey} "HKEY_CURRENT_USER\Software\Unity Technologies\Unity Editor" $0
        ${registry::DeleteKey} "HKEY_CURRENT_USER\Software\Unity\UnityEditor" $0
        ${registry::DeleteKey} "HKEY_CURRENT_USER\Software\PACE Anti-Piracy\InterLok\Reg" $0

    ; SetOriginalKeyBack:
        ${registry::MoveKey} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\Unity Technologies\Unity Editor" "HKEY_CURRENT_USER\Software\Unity Technologies\Unity Editor" $0
        ${registry::MoveKey} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\Unity\UnityEditor" "HKEY_CURRENT_USER\Software\Unity\UnityEditor" $0
        ${registry::MoveKey} "HKEY_CURRENT_USER\Software\PACE Anti-Piracy\InterLok\Reg" "HKEY_CURRENT_USER\Software\PACE Anti-Piracy\InterLok\Reg" $0

        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\Unity Technologies\Unity Editor" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\Unity Technologies" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\Unity\UnityEditor" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\Unity" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PACE Anti-Piracy\InterLok\Reg" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PACE Anti-Piracy\InterLok" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PACE Anti-Piracy" $0

        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\Unity Technologies\Unity Editor" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\Unity Technologies" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\Unity\UnityEditor" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\Unity" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\PACE Anti-Piracy\InterLok\Reg" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\PACE Anti-Piracy\InterLok" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\PACE Anti-Piracy" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com" $0

        ;=== Move the data back
        ;=== Move the app data back
        ;=== Move the editor preferences back
        ClearErrors
        Rename "$APPDATA\Unity\Editor\Preferences" "$DATADIRECTORY\Library\Preferences\Unity\Editor"
        ${If} ${Errors}
            RMDir /r "$DATADIRECTORY\Library\Preferences\Unity\Editor"
            CreateDirectory "$DATADIRECTORY\Library\Preferences\Unity\Editor"
            CopyFiles /SILENT "$APPDATA\Unity\Editor\Preferences\*.*" "$DATADIRECTORY\Library\Preferences\Unity\Editor"
            RMDir /r "$APPDATA\Unity\Editor\Preferences"
        ${EndIf}

        ;=== Move the license back
        ClearErrors
        Rename "$PACEAPDATADIRECTORY\PACE Anti-Piracy\License Files" "$DATADIRECTORY\Library\Application Support\PACE Anti-Piracy\License Files"
        ${If} ${Errors}
            RMDir /r "$DATADIRECTORY\Library\Application Support\PACE Anti-Piracy\License Files"
            CreateDirectory "$DATADIRECTORY\Library\Application Support\PACE Anti-Piracy\License Files"
            CopyFiles /SILENT "$PACEAPDATADIRECTORY\PACE Anti-Piracy\License Files\*.*" "$DATADIRECTORY\Library\Application Support\PACE Anti-Piracy\License Files"
            RMDir /r "$PACEAPDATADIRECTORY\PACE Anti-Piracy\License Files"
        ${EndIf}

        ClearErrors
        Rename "$APPDATA\PACE Anti-Piracy" "$DATADIRECTORY\Library\Application Support\PACE Anti-Piracy"
        ${If} ${Errors}
            CreateDirectory "$DATADIRECTORY\Library\Application Support\PACE Anti-Piracy"
            CopyFiles /SILENT "$APPDATA\PACE Anti-Piracy\*.*" "$DATADIRECTORY\Library\Application Support\PACE Anti-Piracy"
            RMDir /r "$APPDATA\PACE Anti-Piracy"
        ${EndIf}

        ClearErrors
        Rename "$LOCALAPPDATA\PACE Anti-Piracy" "$DATADIRECTORY\Library\Application Support\PACE Anti-Piracy"
        ${If} ${Errors}
            CreateDirectory "$DATADIRECTORY\Library\Application Support\PACE Anti-Piracy"
            CopyFiles /SILENT "$LOCALAPPDATA\PACE Anti-Piracy\*.*" "$DATADIRECTORY\Library\Application Support\PACE Anti-Piracy"
            RMDir /r "$LOCALAPPDATA\PACE Anti-Piracy"
        ${EndIf}

        ClearErrors
        Rename "$COMMONPROGRAMDATA\PACE Anti-Piracy" "$DATADIRECTORY\Library\Application Support\PACE Anti-Piracy"
        ${If} ${Errors}
            CreateDirectory "$DATADIRECTORY\Library\Application Support\PACE Anti-Piracy"
            CopyFiles /SILENT "$COMMONPROGRAMDATA\PACE Anti-Piracy\*.*" "$DATADIRECTORY\Library\Application Support\PACE Anti-Piracy"
            RMDir /r "$COMMONPROGRAMDATA\PACE Anti-Piracy"
        ${EndIf}

        ${If} ${AtLeastWinVista}
            StrCpy $0 "$PROFILE\AppData\Local\VirtualStore\Program Files (x86)\Common Files"
        ${Else}
            StrCpy $0 "$COMMONFILES"
        ${EndIf}
        ClearErrors
        Rename "$0\PACE Anti-Piracy\Log Files" "$DATADIRECTORY\Library\Preferences\Authorization Preferences"
        ${If} ${Errors}
            RMDir /r "$DATADIRECTORY\Library\Preferences\Authorization Preferences"
            CreateDirectory "$DATADIRECTORY\Library\Preferences\Authorization Preferences"
            CopyFiles /SILENT "$0\PACE Anti-Piracy\Log Files\*.*" "$DATADIRECTORY\Library\Preferences\Authorization Preferences"
            RMDir /r "$0\PACE Anti-Piracy\Log Files"
        ${EndIf}

        RMDir /r "$PACEAPDATADIRECTORY\PACE Anti-Piracy"

        ;=== Restore original data
        Rename "$PACEAPDATADIRECTORY\PACE Anti-Piracy.BackupBy${NAME}" "$PACEAPDATADIRECTORY\PACE Anti-Piracy"

        Rename "$APPDATA\Unity\Editor\Preferences.BackupBy${NAME}" "$APPDATA\Unity\Editor\Preferences"

        Rename "$LOCALAPPDATA\Unity\Editor.BackupBy${NAME}" "$LOCALAPPDATA\Unity\Editor"

        ;=== Remove empty folders
        RMDir "$APPDATA\PACE Anti-Piracy"
        RMDir "$APPDATA\Unity\Editor"
        RMDir "$APPDATA\Unity"
        RMDir "$APPDATA"
        RMDir "$LOCALAPPDATA\PACE Anti-Piracy"
        RMDir "$LOCALAPPDATA\Unity"
        RMDir "$LOCALAPPDATA"
        RMDir "$COMMONPROGRAMDATA\PACE Anti-Piracy"
        ${If} ${AtLeastWinVista}
            RMDir "$PROFILE\AppData\Local\VirtualStore\Program Files (x86)\Common Files\PACE Anti-Piracy"
            RMDir "$PROFILE\AppData\Local\VirtualStore\Program Files (x86)\Common Files"
            RMDir "$PROFILE\AppData\Local\VirtualStore\Program Files (x86)"
            RMDir "$PROFILE\AppData\Local\VirtualStore"
            RMDir "$PROFILE\AppData\Local"
            RMDir "$PROFILE\AppData"
            RMDir "$PROFILE"
        ${Else}
            RMDir "$COMMONFILES\PACE Anti-Piracy"
            RMDir "$COMMONFILES"
        ${EndIf}

    ; CleanupRunLocally:
        ${If} $RUNLOCALLY == true
            RMDir /r "$TEMP\${NAME}Live"
        ${EndIf}
SectionEnd
