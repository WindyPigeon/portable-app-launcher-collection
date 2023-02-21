!addplugindir /x86-unicode ".\Plugins"

!define PORTABLEAPPNAME "Spontini-Editor Portable"
!define APPNAME "Spontini-Editor"
!define NAME "Spontini-Editor-Portable"
!define VER "0.0.0.0"
!define WEBSITE "https://github.com/WindyPigeon/portable-app-launcher-collection"
!define DEFAULTAPPDIR "Spontini-Editor"
; !define LAUNCHERLANGUAGE "English"

;=== Program Details
Name "${PORTABLEAPPNAME}"
OutFile "..\..\${NAME}.exe"
; OutFile "..\..\App\LilyPond\usr\bin\${NAME}.exe"
Caption "${PORTABLEAPPNAME} | PortableApps.com"
VIProductVersion "${VER}"
VIAddVersionKey ProductName "${PORTABLEAPPNAME}"
VIAddVersionKey Comments "Allows ${APPNAME} to be run from a removable drive. For additional details, visit ${WEBSITE}"
VIAddVersionKey CompanyName ""
VIAddVersionKey LegalCopyright "WindyPigeon"
VIAddVersionKey FileDescription "${PORTABLEAPPNAME}"
VIAddVersionKey FileVersion "${VER}"
VIAddVersionKey ProductVersion "${VER}"
VIAddVersionKey InternalName "${PORTABLEAPPNAME}"
VIAddVersionKey LegalTrademarks ""
VIAddVersionKey OriginalFilename "${NAME}.exe"
;VIAddVersionKey PrivateBuild ""
;VIAddVersionKey SpecialBuild ""

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
!include TextFunc.nsh
!insertmacro GetParent
!include WordFunc.nsh
!insertmacro WordReplace

;(NSIS Plugins)
!include TextReplace.nsh

;(Custom)
!include ProcFunc.nsh

;=== Program Icon
Icon "..\..\App\AppInfo\appicon.ico"

;=== Icon & Stye ===
BrandingText "WindyPigeon"

;=== Languages
!ifdef LAUNCHERLANGUAGE
    LoadLanguageFile "${NSISDIR}\Contrib\Language files\${LAUNCHERLANGUAGE}.nlf"
    !include PortableApps.comLauncherLANG_${LAUNCHERLANGUAGE}.nsh
!else
    LoadLanguageFile "${NSISDIR}\Contrib\Language files\English.nlf"
    LangString LauncherFileNotFound ${LANG_ENGLISH} "${PORTABLEAPPNAME} cannot be started. You may wish to re-install to fix this issue. (ERROR: $MISSINGFILEORPATH could not be found)"
    LangString LauncherAlreadyRunning ${LANG_ENGLISH} "Another instance of ${APPNAME} is already running. Please close other instances of ${APPNAME} before launching ${PORTABLEAPPNAME}."
    LangString LauncherAskCopyLocal ${LANG_ENGLISH} "${PORTABLEAPPNAME} appears to be running from a location that is read-only. Would you like to temporarily copy it to the local hard drive and run it from there?$\n$\nPrivacy Note: If you say Yes, your personal data within ${PORTABLEAPPNAME} will be temporarily copied to a local drive. Although this copy of your data will be deleted when you close ${PORTABLEAPPNAME}, it may be possible for someone else to access your data later."
    LangString LauncherNoReadOnly ${LANG_ENGLISH} "${PORTABLEAPPNAME} can not run directly from a read-only location and will now close."
    LangString LauncherPathTooLong ${LANG_ENGLISH} "The path to ${PORTABLEAPPNAME} is too long.  Please shorten the path by eliminating some parent directories or shortening directory names."
!endif

;=== Variables
Var INIPATH
Var MISSINGFILEORPATH
Var SERVEREXECUTABLE
Var TEMPDIRECTORY
Var SETTINGSDIRECTORY
Var PROGRAMDIRECTORY
Var RUNLOCALLY
Var SECONDARYLAUNCH
Var DISABLESPLASHSCREEN
Var EXECSTRING
Var ADDITIONALPARAMETERS
Var HTTPSHELLOPENCOMMAND

Section "Main"
	;CheckINI:
        ;=== Find the INI file, if there is one
        IfFileExists "$EXEDIR\${NAME}.ini" "" NoINI
            StrCpy "$INIPATH" "$EXEDIR"

        ;=== Read the parameters from the INI file
        ClearErrors
        ReadINIStr $0 "$INIPATH\${NAME}.ini" "${NAME}" "${APPNAME}Directory"
        ${If} ${Errors}
        ${OrIf} $PROGRAMDIRECTORY == ""
            StrCpy $0 "App\${DEFAULTAPPDIR}"
        ${EndIf}
        StrCpy $PROGRAMDIRECTORY "$EXEDIR\$0"

        ClearErrors
        ReadINIStr $SERVEREXECUTABLE "$INIPATH\${NAME}.ini" "${NAME}" "SpontiniServerExecutable"
        ${If} ${Errors}
        ${OrIf} $SERVEREXECUTABLE == ""
            StrCpy $SERVEREXECUTABLE "SpontiniServer.exe"
        ${EndIf}

        ClearErrors
        ReadINIStr $HTTPSHELLOPENCOMMAND "$INIPATH\${NAME}.ini" "${NAME}" "HttpShellOpenCommand"

        ClearErrors
        ReadINIStr $0 "$INIPATH\${NAME}.ini" "${NAME}" "SettingsDirectory"
        ${If} ${Errors}
        ${OrIf} $SETTINGSDIRECTORY == ""
            StrCpy $0 "Data\settings"
        ${EndIf}
        StrCpy $SETTINGSDIRECTORY "$EXEDIR\$0"

        ReadINIStr $ADDITIONALPARAMETERS "$INIPATH\${NAME}.ini" "${NAME}" "AdditionalParameters"

        ClearErrors
        ReadINIStr $DISABLESPLASHSCREEN "$INIPATH\${NAME}.ini" "${NAME}" "DisableSplashScreen"
        ${If} ${Errors}
        ${OrIf} $DISABLESPLASHSCREEN == ""
            StrCpy $DISABLESPLASHSCREEN "false"
        ${EndIf}

        ClearErrors
        ReadINIStr $RUNLOCALLY "$INIPATH\${NAME}.ini" "${NAME}" "RunLocally"
        ${If} ${Errors}
        ${OrIf} $RUNLOCALLY == ""
            StrCpy $RUNLOCALLY "false"
        ${EndIf}

    ; EndINI:
        IfFileExists "$PROGRAMDIRECTORY\$SERVEREXECUTABLE" FoundProgramEXE

    NoINI:
        ;=== No INI file, so we'll use the defaults
        StrCpy $ADDITIONALPARAMETERS ""
        StrCpy $SERVEREXECUTABLE "SpontiniServer.exe"
        StrCpy $DISABLESPLASHSCREEN "false"

        ${If} ${FileExists} "$EXEDIR\App\${DEFAULTAPPDIR}\$SERVEREXECUTABLE"
            StrCpy $PROGRAMDIRECTORY "$EXEDIR\App\${DEFAULTAPPDIR}"
            StrCpy $SETTINGSDIRECTORY "$EXEDIR\Data\settings"
        ${Else}
            Goto NoProgramEXE
        ${EndIf}
        Goto FoundProgramEXE

    NoProgramEXE:
        ;=== Program executable not where expected
        StrCpy $MISSINGFILEORPATH "$SERVEREXECUTABLE"
        MessageBox MB_OK|MB_ICONEXCLAMATION "$(LauncherFileNotFound)"
        Abort

    FoundProgramEXE:
        ;=== Is launcher already running?
        ${GetBaseName} "$EXEFILE" $0
        System::Call 'kernel32::CreateMutex(i 0, i 0, t "${NAME}-$0") ?e'
        Pop $0
        ${IfNot} $0 == 0
            StrCpy $SECONDARYLAUNCH true
        ${EndIf}

        ClearErrors
        ReadEnvStr $TEMPDIRECTORY "PAL:_TEMP"
        ${If} ${Errors}
            StrCpy $TEMPDIRECTORY "$TEMP"
        ${EndIf}

        ;=== Run locally if needed (aka Live)
        ${If} $RUNLOCALLY == true
        ${AndIf} $SECONDARYLAUNCH != true
            CreateDirectory "$TEMPDIRECTORY\${NAME}Live\App\${DEFAULTAPPDIR}"
            StrCpy $PROGRAMDIRECTORY "$TEMPDIRECTORY\${NAME}Live\App\${DEFAULTAPPDIR}"
            CopyFiles /SILENT "$PROGRAMDIRECTORY\*.*" "$TEMPDIRECTORY\${NAME}Live\App\${DEFAULTAPPDIR}"

            CreateDirectory "$TEMPDIRECTORY\${NAME}Live\Data\settings"
            StrCpy $SETTINGSDIRECTORY "$TEMPDIRECTORY\${NAME}Live\Data\settings"
            CopyFiles /SILENT "$SETTINGSDIRECTORY\*.*" "$TEMPDIRECTORY\${NAME}Live\Data\settings"
        ${EndIf}

        Rename "$LOCALAPPDATA\fontconfig\cache" "$LOCALAPPDATA\fontconfig\cache.BackupBy${NAME}"

        ;=== Create ExecString
        StrCpy $EXECSTRING '"$PROGRAMDIRECTORY\$SERVEREXECUTABLE"'

        ;=== Get any passed parameters
        ${GetParameters} $0
        ${If} $0 == ""
            StrCpy $EXECSTRING "$EXECSTRING $0"
        ${EndIf}

        ;=== Additional Parameters
        ${If} $ADDITIONALPARAMETERS == ""
            StrCpy $EXECSTRING "$EXECSTRING $ADDITIONALPARAMETERS"
        ${EndIf}

    ; DisplaySplash:
        StrCmp $DISABLESPLASHSCREEN "true" SkipSplashScreen
            ;=== Show the splash screen before processing the files
            ${If} ${FileExists} "$EXEDIR\App\AppInfo\Launcher\splash.jpg"
                newadvsplash::show /NOUNLOAD 2000 0 0 -1 /L "$EXEDIR\App\AppInfo\Launcher\splash.jpg"
            ${EndIf}

    SkipSplashScreen:
        ${If} $SECONDARYLAUNCH != true
            RMDir /r "$TEMPDIRECTORY\${NAME}Temp"
        ${EndIf}
        CreateDirectory "$TEMPDIRECTORY\${NAME}Temp"
        System::Call 'Kernel32::SetEnvironmentVariable(t "TMP", t "$TEMPDIRECTORY\${NAME}Temp") i .r0'

    ; LaunchNow:
        ${GetFileName} "$SERVEREXECUTABLE" $0
        ${GetProcessPID} "$0" $0
        ${IfNot} $0 > 0
            Exec "$EXECSTRING"
        ${EndIf}

        ${If} $HTTPSHELLOPENCOMMAND != ""
            ${WordReplace} "$HTTPSHELLOPENCOMMAND" '"%1"' '"http://localhost:8000/spontini-editor"' "+" $HTTPSHELLOPENCOMMAND
            ${WordReplace} "$HTTPSHELLOPENCOMMAND" "%1" "http://localhost:8000/spontini-editor" "+" $HTTPSHELLOPENCOMMAND
            Exec "$HTTPSHELLOPENCOMMAND"
        ${ElseIf} ${FileExists} "$EXEDIR\FirefoxPortable.exe"
            Exec '"$EXEDIR\FirefoxPortable.exe" -url "http://localhost:8000/spontini-editor"'
        ${ElseIf} ${FileExists} "$EXEDIR\..\FirefoxPortable\FirefoxPortable.exe"
            Exec '"$EXEDIR\..\FirefoxPortable\FirefoxPortable.exe" -url "http://localhost:8000/spontini-editor"'
        ${Else}
            ExecShell open "http://localhost:8000/spontini-editor"
        ${EndIf}

        ${If} $SECONDARYLAUNCH == true
            Goto TheEnd
        ${Else}
            Goto CheckRunning
        ${EndIf}

    CheckRunning:
        ${GetFileName} $SERVEREXECUTABLE "$0"
        ${Do}
            ${ProcessWaitClose} "$0" -1 $1
        ${LoopWhile} $1 > 0

    ; CleanupCache:
        RMDir /r "$LOCALAPPDATA\fontconfig\cache"
        Rename "$LOCALAPPDATA\fontconfig\cache.BackupBy${NAME}" "$LOCALAPPDATA\fontconfig\cache"
        RMDir "$LOCALAPPDATA\fontconfig\cache"
        RMDir "$LOCALAPPDATA\fontconfig"
        RMDir "$LOCALAPPDATA"

    ; CleanupRunLocally:
        ${If} $RUNLOCALLY == true
            RMDir /r "$TEMPDIRECTORY\${NAME}Live"
        ${EndIf}

        RMDir /r "$TEMPDIRECTORY\${NAME}Temp"

    TheEnd:
        newadvsplash::stop /WAIT
SectionEnd
