!addplugindir /x86-unicode ".\Plugins"

!ifndef VER_MAJOR
    !define VER_MAJOR "2018"
!endif

!ifndef VER_MINOR
    !define VER_MINOR "1"
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
!define AppID "UnityEditor5.xPortable"
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
Var LOCALAPPDATAPATH
Var PORTABLEAPPS.COMDOCUMETSPATH
Var RUNLOCALLY
Var MISSINGFILEORPATH

Section "Main"
	;=== Setup variables
        ReadEnvStr $LOCALAPPDATAPATH "LOCALAPPDATA"

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

        ClearErrors
        ReadEnvStr $PORTABLEAPPS.COMDOCUMETSPATH "PortableApps.comDocuments"
        ${IfNot} ${Errors}
        ${AndIf} ${FileExists} "$PORTABLEAPPS.COMDOCUMETSPATH\*.*"
            Nop
        ${ElseIf} ${FileExists} "$PORTABLEAPPSBASEDIRECTORY\Documents\*.*"
            StrCpy $PORTABLEAPPS.COMDOCUMETSPATH "$PORTABLEAPPSBASEDIRECTORY\Documents"
        ${ElseIf} ${FileExists} "$CURRENTDRIVE\Documents\*.*"
            StrCpy $PORTABLEAPPS.COMDOCUMETSPATH "$CURRENTDRIVE\Documents"
        ${Else}
            StrCpy $PORTABLEAPPS.COMDOCUMETSPATH "$CURRENTDRIVE"
        ${EndIf}
        WriteINIStr "$SETTINGSDIRECTORY\${AppID}Settings.ini" "LastRunEnvironment" "LastPortableApps.comDocumentsDirectory" $PORTABLEAPPS.COMDOCUMETSPATH

        ${IfNot} ${FileExists} "$SETTINGSDIRECTORY\com.unity3d.UnityEditor5.x.reg"
            FileOpen $0 "$SETTINGSDIRECTORY\com.unity3d.UnityEditor5.x.reg" w
            FileWrite $0 "Windows Registry Editor Version 5.00$\r$\n\
                    $\r$\n"
            FileClose $0

            CreateDirectory "$PORTABLEAPPS.COMDOCUMETSPATH\Unity Projects"
            ${WordReplace} "$PORTABLEAPPS.COMDOCUMETSPATH" "\" "/" + $0
            WriteINIStr "$SETTINGSDIRECTORY\com.unity3d.UnityEditor5.x.reg" "HKEY_CURRENT_USER\Software\Unity Technologies\Unity Editor 5.x" '"kNewProjectsPath"' '"$0/Unity Projects"'

            WriteINIStr "$SETTINGSDIRECTORY\com.unity3d.UnityEditor5.x.reg" "HKEY_CURRENT_USER\Software\Unity Technologies\Unity Editor 5.x" '"GICacheEnableCustomPath"' "dword:00000001"

            ${WordReplace} "$DATADIRECTORY" "\" "/" + $0
            WriteINIStr "$SETTINGSDIRECTORY\com.unity3d.UnityEditor5.x.reg" "HKEY_CURRENT_USER\Software\Unity Technologies\Unity Editor 5.x" '"GICacheFolder"' '"$0/Library/Caches/com.unity3d.UnityEditor/GiCache"'
        ${Else}
            ${If} $LASTDIRECTORY != ""
            ${AndIf} $LASTDIRECTORY != $CURRENTDIRECTORY
                ${ReplaceInFile} "$SETTINGSDIRECTORY\com.unity3d.UnityEditor5.x.reg" "$LASTDRIVE/$LASTDIRECTORY" "$EXEDIR"

                ${registry::StrToHex} "$LASTDRIVE/$LASTDIRECTORY" $0
                StrCpy $1 "$0" 2
                StrCpy $2 2
                StrLen $3 "$0"
                ${While} $2 < $3
                    StrCpy $4 "$0" 2 $2
                    StrCpy $1 "$1,$4"
                    IntOp $2 $2 + 2
                ${EndWhile}
                ${registry::StrToHex} "$EXEDIR" $5
                StrCpy $6 "$5" 2
                StrCpy $7 2
                StrLen $8 "$0"
                ${While} $7 < $8
                    StrCpy $9 "$5" 2 $7
                    StrCpy $6 "$6,$9"
                    IntOp $7 $7 + 2
                ${EndWhile}
                ${ReplaceInFile} "$SETTINGSDIRECTORY\com.unity3d.UnityEditor5.x.reg" "$1" "$6"
            ${EndIf}

            ${If} $LASTPORTABLEAPPSBASEDIRECTORY != ""
            ${AndIf} $LASTPORTABLEAPPSBASEDIRECTORY != $PORTABLEAPPSBASEDIRECTORY
                ${ReplaceInFile} "$SETTINGSDIRECTORY\com.unity3d.UnityEditor5.x.reg" "$LASTDRIVE/$LASTPORTABLEAPPSBASEDIRECTORY" "$CURRENTDRIVE/$PORTABLEAPPSBASEDIRECTORY"

                ${registry::StrToHex} "$LASTDRIVE/$LASTPORTABLEAPPSBASEDIRECTORY" $0
                StrCpy $1 "$0" 2
                StrCpy $2 2
                StrLen $3 "$0"
                ${While} $2 < $3
                    StrCpy $4 "$0" 2 $2
                    StrCpy $1 "$1,$4"
                    IntOp $2 $2 + 2
                ${EndWhile}
                ${registry::StrToHex} "$CURRENTDRIVE/$PORTABLEAPPSBASEDIRECTORY" $5
                StrCpy $6 "$5" 2
                StrCpy $7 2
                StrLen $8 "$0"
                ${While} $7 < $8
                    StrCpy $9 "$5" 2 $7
                    StrCpy $6 "$6,$9"
                    IntOp $7 $7 + 2
                ${EndWhile}
                ${ReplaceInFile} "$SETTINGSDIRECTORY\com.unity3d.UnityEditor5.x.reg" "$1" "$6"
            ${EndIf}

            ${If} $LASTDRIVE != ""
            ${AndIf} $LASTDRIVE != $CURRENTDRIVE
                ${ReplaceInFile} "$SETTINGSDIRECTORY\com.unity3d.UnityEditor5.x.reg" "$LASTDRIVE/" "$CURRENTDRIVE/"

                ${registry::StrToHex} "$LASTDRIVE/" $0
                StrCpy $1 "$0" 2
                StrCpy $2 2
                StrLen $3 "$0"
                ${While} $2 < $3
                    StrCpy $4 "$0" 2 $2
                    StrCpy $1 "$1,$4"
                    IntOp $2 $2 + 2
                ${EndWhile}
                ${registry::StrToHex} "$CURRENTDRIVE/" $5
                StrCpy $6 "$5" 2
                StrCpy $7 2
                StrLen $8 "$0"
                ${While} $7 < $8
                    StrCpy $9 "$5" 2 $7
                    StrCpy $6 "$6,$9"
                    IntOp $7 $7 + 2
                ${EndWhile}
                ${ReplaceInFile} "$SETTINGSDIRECTORY\com.unity3d.UnityEditor5.x.reg" "$1" "$6"
            ${EndIf}
        ${EndIf}

    ; BackupOriginalData:
        ;=== Backup original app data
        ;=== Backup original editor preferences, packages and REST certificate
        Rename "$APPDATA\Unity" "$APPDATA\Unity.BackupBy${NAME}"

        ;=== Backup original local app data
        ;=== Backup original logs and cache
        Rename "$LOCALAPPDATA\Unity" "$LOCALAPPDATA\Unity.BackupBy${NAME}"
        ${If} "$LOCALAPPDATA" != "$LOCALAPPDATAPATH"
            Rename "$LOCALAPPDATAPATH\Unity" "$LOCALAPPDATAPATH\Unity.BackupBy${NAME}"
        ${EndIf}

        ;=== Backup original local low app data
        ;=== Backup original browser cache and cookies
        Rename "$PROFILE\AppData\LocalLow\Unity\Browser" "$PROFILE\AppData\LocalLow\Unity\Browser.BackupBy${NAME}"

        ;=== Backup original editor value, config and archived events
        Rename "$PROFILE\AppData\LocalLow\Unity\Editor" "$PROFILE\AppData\LocalLow\Unity\Editor.BackupBy${NAME}"

    ; RestoreData:
        ;=== Restore the license
        ${GetProcessPath} "Unity Hub.exe" $0
        ${If} $0 == 0
            ;=== Backup original licenses
            Rename "$COMMONPROGRAMDATA\Unity" "$COMMONPROGRAMDATA\Unity.BackupBy${NAME}"
            
            ClearErrors
            Rename "$DATADIRECTORY\Library\Application Support\Unity\Unity_lic.ulf" "$COMMONPROGRAMDATA\Unity\Unity_lic.ulf"
            ${If} ${Errors}
                CreateDirectory "$COMMONPROGRAMDATA\Unity"
                CopyFiles /SILENT "$DATADIRECTORY\Library\Application Support\Unity\Unity_lic.ulf" "$COMMONPROGRAMDATA\Unity"
                CopyFiles /SILENT "$DATADIRECTORY\Library\Application Support\Unity\Unity_lic.ulf.backup" "$COMMONPROGRAMDATA\Unity"
            ${Else}
                Rename "$DATADIRECTORY\Library\Application Support\Unity\Unity_lic.ulf.backup" "$COMMONPROGRAMDATA\Unity\Unity_lic.ulf.backup"
            ${EndIf}
        ${EndIf}

        ;=== Restore the editor value, config and archived events
        ${GetRoot} "$DATADIRECTORY\Library\Application Support\Unity\Editor" $0
        ${GetRoot} "$PROFILE\AppData\LocalLow\Unity\Editor" $1
        ${If} $0 == $1
            Rename "$DATADIRECTORY\Library\Application Support\Unity\Editor" "$PROFILE\AppData\LocalLow\Unity\Editor"
        ${Else}
            CreateDirectory "$PROFILE\AppData\LocalLow\Unity\Editor"
            CopyFiles /SILENT "$DATADIRECTORY\Library\Application Support\Unity\Editor\*.*" "$PROFILE\AppData\LocalLow\Unity\Editor"
        ${EndIf}

        ;=== Rename the previous Editor.log to Editor-prev.log
        Delete "$DATADIRECTORY\Library\Logs\Unity\Editor-prev.log"
        Rename "$DATADIRECTORY\Library\Logs\Unity\Editor.log" "$DATADIRECTORY\Library\Logs\Unity\Editor-prev.log"

        ;=== Restore the editor preferences
        ${GetRoot} "$DATADIRECTORY\Library\Preferences\Unity\Editor-5.x" $0
        ${GetRoot} "$APPDATA\Unity\Editor-5.x\Preferences" $1
        ${If} $0 == $1
            Rename "$DATADIRECTORY\Library\Preferences\Unity\Editor-5.x" "$APPDATA\Unity\Editor-5.x\Preferences"
        ${Else}
            CreateDirectory "$APPDATA\Unity\Editor-5.x\Preferences"
            CopyFiles /SILENT "$DATADIRECTORY\Library\Preferences\Unity\Editor-5.x\*.*" "$APPDATA\Unity\Editor-5.x\Preferences"
        ${EndIf}

        ;=== Restore the asset store
        ${GetRoot} "$DATADIRECTORY\Library\Unity\Asset Store-5.x" $0
        ${GetRoot} "$APPDATA\Unity\Asset Store-5.x" $1
        ${If} $0 == $1
            Rename "$DATADIRECTORY\Library\Unity\Asset Store-5.x" "$APPDATA\Unity\Asset Store-5.x"
        ${Else}
            CreateDirectory "$PROFILE\AppData\LocalLow\Unity\Browser"
            CopyFiles /SILENT "$DATADIRECTORY\Library\Unity\Asset Store-5.x\*.*" "$APPDATA\Unity\Asset Store-5.x"
        ${EndIf}

        ;=== Restore the browser cache and cookies
        ${GetRoot} "$DATADIRECTORY\Library\Unity\Browser" $0
        ${GetRoot} "$PROFILE\AppData\LocalLow\Unity\Browser" $1
        ${If} $0 == $1
            Rename "$DATADIRECTORY\Library\Unity\Browser" "$PROFILE\AppData\LocalLow\Unity\Browser"
        ${Else}
            CreateDirectory "$PROFILE\AppData\LocalLow\Unity\Browser"
            CopyFiles /SILENT "$DATADIRECTORY\Library\Unity\Browser\*.*" "$PROFILE\AppData\LocalLow\Unity\Browser"
        ${EndIf}

        ;=== Restore the packages
        ${GetRoot} "$DATADIRECTORY\Library\Unity\Packages" $0
        ${GetRoot} "$APPDATA\Unity\Packages" $1
        ${If} $0 == $1
            Rename "$DATADIRECTORY\Library\Unity\Packages" "$APPDATA\Unity\Packages"
        ${Else}
            CreateDirectory "$APPDATA\Unity\Packages"
            CopyFiles /SILENT "$DATADIRECTORY\Library\Unity\Packages\*.*" "$APPDATA\Unity\Packages"
        ${EndIf}

        ;=== Restore the REST certificate
        Rename "$DATADIRECTORY\Library\Unity\rest-certificate.pem" "$APPDATA\Unity\rest-certificate.pem"
        ${If} ${Errors}
            CreateDirectory "$APPDATA\Unity"
            CopyFiles /SILENT "$DATADIRECTORY\Library\Unity\rest-certificate.pem" "$APPDATA\Unity"
        ${EndIf}


    ; RegistryBackup:
        ;=== Backup the registry
        ${registry::KeyExists} "HKEY_CURRENT_USER\Software\Unity\UnityEditor" $0
        ${If} $0 != -1
            ${registry::MoveKey} "HKEY_CURRENT_USER\Software\Unity\UnityEditor" "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\Unity\UnityEditor" $0
        ${EndIf}

        ${registry::KeyExists} "HKEY_CURRENT_USER\Software\Unity Technologies\Unity Editor 5.x" $0
        ${If} $0 != -1
            ${registry::MoveKey} "HKEY_CURRENT_USER\Software\Unity Technologies\Unity Editor 5.x" "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\Unity Technologies\Unity Editor 5.x" $0
        ${EndIf}

    ; RestoreTheKey:
        ${registry::RestoreKey} "$SETTINGSDIRECTORY\com.unity3d.UnityEditor5.x.reg" $0

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
        ${registry::SaveKey} "HKEY_CURRENT_USER\Software\Unity Technologies\Unity Editor 5.x" "$SETTINGSDIRECTORY\com.unity3d.UnityEditor5.x.reg" "" $0
        ${registry::SaveKey} "HKEY_CURRENT_USER\Software\Unity\UnityEditor" "$SETTINGSDIRECTORY\com.unity3d.UnityEditor.reg" "" $0

    ; CleanupRegistry:
        ${registry::DeleteKey} "HKEY_CURRENT_USER\Software\Unity Technologies\Unity Editor 5.x" $0
        ${registry::DeleteKey} "HKEY_CURRENT_USER\Software\Unity\UnityEditor" $0

    ; SetOriginalKeyBack:
        ${registry::MoveKey} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\Unity Technologies\Unity Editor 5.x" "HKEY_CURRENT_USER\Software\Unity Technologies\Unity Editor 5.x" $0
        ${registry::MoveKey} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\Unity\UnityEditor" "HKEY_CURRENT_USER\Software\Unity\UnityEditor" $0

        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\Unity Technologies\Unity Editor 5.x" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\Unity Technologies" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\Unity\UnityEditor" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\Unity" $0

        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\Unity Technologies\Unity Editor 5.x" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\Unity Technologies" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\Unity\UnityEditor" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\Unity" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com" $0

        ;=== Move the data back
        ;=== Move the app data back
        ;=== Move the asset store back
        ClearErrors
        Rename "$APPDATA\Unity\Asset Store-5.x" "$DATADIRECTORY\Library\Unity\Asset Store-5.x"
        ${If} ${Errors}
            RMDir /r "$DATADIRECTORY\Library\Unity\Asset Store-5.x"
            CreateDirectory "$DATADIRECTORY\Library\Unity\Asset Store-5.x"
            CopyFiles /SILENT "$APPDATA\Unity\Asset Store-5.x\*.*" "$DATADIRECTORY\Library\Unity\Asset Store-5.x"
            RMDir /r "$APPDATA\Unity\Asset Store-5.x"
        ${EndIf}

        ;=== Dispose unused caches folder
        RMDir /r "$APPDATA\Unity\Caches"

        ;=== Move the editor preferences back
        ClearErrors
        Rename "$APPDATA\Unity\Editor-5.x\Preferences" "$DATADIRECTORY\Library\Preferences\Unity\Editor-5.x"
        ${If} ${Errors}
            RMDir /r "$DATADIRECTORY\Library\Preferences\Unity\Editor-5.x"
            CreateDirectory "$DATADIRECTORY\Library\Preferences\Unity\Editor-5.x"
            CopyFiles /SILENT "$APPDATA\Unity\Editor-5.x\Preferences\*.*" "$DATADIRECTORY\Library\Preferences\Unity\Editor-5.x"
            RMDir /r "$APPDATA\Unity\Editor-5.x\Preferences"
        ${EndIf}

        ;=== Move the packages back
        ClearErrors
        Rename "$APPDATA\Unity\Packages" "$DATADIRECTORY\Library\Unity\Packages"
        ${If} ${Errors}
            RMDir /r "$DATADIRECTORY\Library\Unity\Packages"
            CreateDirectory "$DATADIRECTORY\Library\Unity\Packages"
            CopyFiles /SILENT "$APPDATA\Unity\Packages\*.*" "$DATADIRECTORY\Library\Unity\Packages"
            RMDir /r "$APPDATA\Unity\Packages"
        ${EndIf}

        ;=== Move the REST certificate back
        ClearErrors
        Rename "$APPDATA\Unity\rest-certificate.pem" "$DATADIRECTORY\Library\Unity\rest-certificate.pem"
        ${If} ${Errors}
            Delete "$DATADIRECTORY\Library\Unity\rest-certificate.pem"
            CreateDirectory "$DATADIRECTORY\Library\Unity"
            CopyFiles /SILENT "$APPDATA\Unity\rest-certificate.pem" "$DATADIRECTORY\Library\Unity"
            Delete "$APPDATA\Unity\rest-certificate.pem"
        ${EndIf}

        ;=== Move the local app data files back
        ;=== Save the npm cache and packages cache
        ClearErrors
        Rename "$LOCALAPPDATAPATH\Unity\cache" "$DATADIRECTORY\Library\Unity\cache"
        ${If} ${Errors}
            RMDir /r "$DATADIRECTORY\Library\Unity\cache\npm"
            RMDir /r "$DATADIRECTORY\Library\Unity\cache\packages"
            CreateDirectory "$DATADIRECTORY\Library\Unity\cache"
            CopyFiles /SILENT "$LOCALAPPDATAPATH\Unity\cache\*.*" "$DATADIRECTORY\Library\Unity\cache"
            RMDir /r "$LOCALAPPDATAPATH\Unity\cache"
        ${EndIf}

        ;=== Save the logs of the Unity package manager (upm.log)
        ClearErrors
        Rename "$LOCALAPPDATAPATH\Unity\Editor" "$DATADIRECTORY\Library\Logs\Unity"
        ${If} ${Errors}
            Delete "$DATADIRECTORY\Library\Logs\Unity\upm.log"
            CreateDirectory "$DATADIRECTORY\Library\Logs\Unity"
            CopyFiles /SILENT "$LOCALAPPDATAPATH\Unity\Editor\*.*" "$DATADIRECTORY\Library\Logs\Unity"
            RMDir /r "$LOCALAPPDATAPATH\Unity\Editor"
        ${EndIf}

        ;=== Remove index-local.xml and empty 2018.* folder
        RMDir /r "$LOCALAPPDATA\Unity"

        ;=== Move the local low app data files back
        ;=== Move the browser caches and cookies back
        ClearErrors
        Rename "$PROFILE\AppData\LocalLow\Unity\Browser" "$DATADIRECTORY\Library\Unity\Browser"
        ${If} ${Errors}
            RMDir /r "$DATADIRECTORY\Library\Unity\Browser"
            CreateDirectory "$DATADIRECTORY\Library\Unity\Browser"
            CopyFiles /SILENT "$PROFILE\AppData\LocalLow\Unity\Browser\*.*" "$DATADIRECTORY\Library\Unity\Browser"
            RMDir /r "$PROFILE\AppData\LocalLow\Unity\Browser"
        ${EndIf}

        ;=== Move the editor value, config and archived events back
        ClearErrors
        Rename "$PROFILE\AppData\LocalLow\Unity\Editor" "$DATADIRECTORY\Library\Application Support\Unity\Editor"
        ${If} ${Errors}
            RMDir /r "$DATADIRECTORY\Library\Application Support\Unity\Editor"
            CreateDirectory "$DATADIRECTORY\Library\Application Support\Unity\Editor"
            CopyFiles /SILENT "$PROFILE\AppData\LocalLow\Unity\Editor\*.*" "$DATADIRECTORY\Library\Application Support\Unity\Editor"
            RMDir /r "$PROFILE\AppData\LocalLow\Unity\Editor"
        ${EndIf}

        ;=== Move the all users' data back
        ;=== Move the license back
        ${GetProcessPath} "Unity Hub.exe" $0
        ${If} $0 == 0
            ClearErrors
            Rename "$COMMONPROGRAMDATA\Unity" "$DATADIRECTORY\Library\Application Support\Unity"
            ${If} ${Errors}
                Delete "$DATADIRECTORY\Library\Application Support\Unity\Unity_lic.ulf"
                Delete "$DATADIRECTORY\Library\Application Support\Unity\Unity_lic.ulf.backup"
                CreateDirectory "$DATADIRECTORY\Library\Application Support\Unity"
                CopyFiles /SILENT "$COMMONPROGRAMDATA\Unity\*.*" "$DATADIRECTORY\Library\Application Support\Unity"
                RMDir /r "$COMMONPROGRAMDATA\Unity"
            ${EndIf}
        ${EndIf}

        ;=== Restore original data
        Rename "$APPDATA\Unity.BackupBy${NAME}" "$APPDATA\Unity"

        Rename "$LOCALAPPDATA\Unity.BackupBy${NAME}" "$LOCALAPPDATA\Unity"
        ${If} "$LOCALAPPDATA" != "$LOCALAPPDATAPATH"
            Rename "$LOCALAPPDATAPATH\Unity.BackupBy${NAME}" "$LOCALAPPDATAPATH\Unity"
        ${EndIf}

        Rename "$PROFILE\AppData\LocalLow\Unity\Browser.BackupBy${NAME}" "$PROFILE\AppData\LocalLow\Unity\Browser"
        Rename "$PROFILE\AppData\LocalLow\Unity\Editor.BackupBy${NAME}" "$PROFILE\AppData\LocalLow\Unity\Editor"

        Rename "$COMMONPROGRAMDATA\Unity.BackupBy${NAME}" "$COMMONPROGRAMDATA\Unity"

        ;=== Remove empty folders
        RMDir "$APPDATA\Unity\Editor-5.x"
        RMDir "$APPDATA\Unity"
        RMDir "$APPDATA"
        RMDir "$LOCALAPPDATA\Unity"
        RMDir "$LOCALAPPDATA"
        RMDir "$LOCALAPPDATAPATH\Unity"
        RMDir "$LOCALAPPDATAPATH"
        RMDir "$PROFILE\AppData\LocalLow\Unity"
        RMDir "$PROFILE\AppData\LocalLow"
        RMDir "$PROFILE\AppData"
        RMDir "$PROFILE"
        RMDir "$COMMONPROGRAMDATA\Unity"
        RMDir "$COMMONPROGRAMDATA"

    ; CleanupRunLocally:
        ${If} $RUNLOCALLY == true
            RMDir /r "$TEMP\${NAME}Live"
        ${EndIf}
SectionEnd
