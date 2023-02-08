!addplugindir /x86-unicode ".\Plugins"

!define PORTABLEAPPNAME "LilyPond Portable"
!define APPNAME "LilyPond"
!define NAME "LilyPondPortable"
!define VER "0.0.0.0"
!define WEBSITE "https://github.com/WindyPigeon/portable-app-launcher-collection"
!define DEFAULTEXE "lilypond-windows.exe"
!define DEFAULTAPPDIR "LilyPond\usr\bin"
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
Var PROGRAMDIRECTORY
Var SETTINGSDIRECTORY
Var ADDITIONALPARAMETERS
Var EXECSTRING
Var PROGRAMEXECUTABLE
Var INIPATH
Var DISABLESPLASHSCREEN
Var RUNLOCALLY
Var DATADIRECTORY
Var PACKAGEDIR
Var USERPROFILEPATH
Var SECONDARYLAUNCH
Var MISSINGFILEORPATH

Section "Main"
	;=== Setup variables
        ReadEnvStr $USERPROFILEPATH "USERPROFILE"

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
        ReadINIStr $0 "$INIPATH\${NAME}.ini" "${NAME}" "SettingsDirectory"
        ${If} ${Errors}
        ${OrIf} $SETTINGSDIRECTORY == ""
            StrCpy $0 "Data\settings"
        ${EndIf}
        StrCpy $SETTINGSDIRECTORY "$EXEDIR\$0"

        ${If} ${FileExists} "$EXEDIR\App"
            StrCpy $PACKAGEDIR "$EXEDIR"
        ${Else}
            ${GetParent} "$EXEDIR" $0
            ${GetBaseName} "$0" $1
            ${DoUntil} $0 == ""
                ${GetParent} "$0" $0
                ${GetBaseName} "$0" $1
                ${If} $1 == "App"
                    ${GetParent} "$0" $0
                    StrCpy $PACKAGEDIR "$0"
                    ${ExitDo}
                ${EndIf}
            ${Loop}
        ${EndIf}

        ReadINIStr $ADDITIONALPARAMETERS "$INIPATH\${NAME}.ini" "${NAME}" "AdditionalParameters"

        ClearErrors
        ReadINIStr $PROGRAMEXECUTABLE "$INIPATH\${NAME}.ini" "${NAME}" "${APPNAME}Executable"
        ${If} ${Errors}
        ${OrIf} $PROGRAMEXECUTABLE == ""
            StrCpy $PROGRAMEXECUTABLE "${DEFAULTEXE}"
        ${EndIf}

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
        IfFileExists "$PROGRAMDIRECTORY\$PROGRAMEXECUTABLE" FoundProgramEXE

    NoINI:
        ;=== No INI file, so we'll use the defaults
        StrCpy $ADDITIONALPARAMETERS ""
        StrCpy $PROGRAMEXECUTABLE "${DEFAULTEXE}"
        StrCpy $DISABLESPLASHSCREEN "false"

        ${If} ${FileExists} "$EXEDIR\App\${DEFAULTAPPDIR}\${DEFAULTEXE}"
            StrCpy $PROGRAMDIRECTORY "$EXEDIR\App\${DEFAULTAPPDIR}"
            StrCpy $SETTINGSDIRECTORY "$EXEDIR\Data\settings"
        ${ElseIf} ${FileExists} "$EXEDIR\${DEFAULTEXE}"
            StrCpy $PROGRAMDIRECTORY "$EXEDIR"
            ${GetParent} "$PROGRAMDIRECTORY" $0
            ${GetBaseName} "$0" $1
            ${DoUntil} $0 == ""
                ${GetParent} "$0" $0
                ${GetBaseName} "$0" $1
                ${If} $1 == "App"
                    ${GetParent} "$0" $0
                    StrCpy $PACKAGEDIR "$0"
                    StrCpy $DATADIRECTORY "$0\Data"
                    StrCpy $SETTINGSDIRECTORY "$0\Data\settings"
                    ${ExitDo}
                ${EndIf}
            ${Loop}
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
        ;=== Is launcher already running?
        ${GetBaseName} "$EXEFILE" $0
        System::Call 'kernel32::CreateMutex(i 0, i 0, t "${NAME}-$0") ?e'
        Pop $0
        ${IfNot} $0 == 0
            StrCpy $SECONDARYLAUNCH true
        ${EndIf}

        ;=== Run locally if needed (aka Live)
        ${If} $RUNLOCALLY == true
        ${AndIf} $SECONDARYLAUNCH != true
            CreateDirectory "$TEMP\${NAME}Live\App\LilyPond\usr\bin"
            StrCpy $PROGRAMDIRECTORY "$TEMP\${NAME}Live\App\LilyPond\usr\bin"
            CopyFiles /SILENT "$PROGRAMDIRECTORY\*.*" "$TEMP\${NAME}Live\App\LilyPond\usr\bin"

            CreateDirectory "$TEMP\${NAME}Live\Data\settings"
            StrCpy $SETTINGSDIRECTORY "$TEMP\${NAME}Live\Data\settings"
            CopyFiles /SILENT "$SETTINGSDIRECTORY\*.*" "$TEMP\${NAME}Live\Data\settings"
        ${EndIf}

        Rename "$USERPROFILEPATH\.lilypond-2.8.0-font.cache-1" "$USERPROFILEPATH\.lilypond-2.8.0-font.cache-1.BackupBy${NAME}"

        ;=== Create ExecString
        ;=== Get any passed parameters
        ${GetParameters} $0
        ${If} $0 == ""
        ${AndIf} $ADDITIONALPARAMETERS == ""
        ${AndIf} ${FileExists} "$PROGRAMDIRECTORY\lilypad.exe"
            StrCpy $EXECSTRING "$PROGRAMDIRECTORY\lilypad.exe"
            ${GetParent} "$PROGRAMDIRECTORY" $0
            ${If} ${FileExists} "$0/share/lilypond/current/ly/Welcome_to_LilyPond.ly"
                ${WordReplace} "$0" "\" "/" "+" $0
                StrCpy $EXECSTRING '$EXECSTRING +0:0 "$0/share/lilypond/current/ly/Welcome_to_LilyPond.ly"'
            ${EndIf}
        ${Else}
            StrCpy $EXECSTRING '"$PROGRAMDIRECTORY\$PROGRAMEXECUTABLE"'
            StrCpy $EXECSTRING "$EXECSTRING $0"
            StrCpy $EXECSTRING "$EXECSTRING $ADDITIONALPARAMETERS"
            StrCpy $DISABLESPLASHSCREEN "true"

            System::Call "kernel32::GetCurrentDirectory(i ${NSIS_MAX_STRLEN}, t .r0)"
            SetOutPath $0
        ${EndIf}

    ; DisplaySplash:
        StrCmp $DISABLESPLASHSCREEN "true" SkipSplashScreen
            ;=== Show the splash screen before processing the files
            ${If} ${FileExists} "$PACKAGEDIR\AppInfo\Launcher\splash.jpg"
                newadvsplash::show /NOUNLOAD 2000 0 0 -1 /L "$PACKAGEDIR\AppInfo\Launcher\splash.jpg"
            ${EndIf}

    SkipSplashScreen:

    ; RunProgram:

    ; LaunchNow:
        StrCmp $SECONDARYLAUNCH "true" StartProgramAndExit
        ExecWait "$EXECSTRING"

    CheckRunning:
        ${ProcessWaitClose} "$0" -1 $0
        ${If} $0 > 0
            Goto CheckRunning
        ${Else}
            ${Do}
                ${ProcessWaitClose} "lilypad.exe" -1 $0
            ${LoopWhile} $0 > 0
        ${EndIf}
        Goto CleanupRunLocally

    StartProgramAndExit:
        Exec "$EXECSTRING"
        Goto TheEnd

    CleanupRunLocally:
        StrCmp $RUNLOCALLY "true" "" CleanupLilypondFontsCache
        RMDir /r "$TEMP\${NAME}Live\"

    CleanupLilypondFontsCache:
        ${If} ${ProcessExists} "$PROGRAMEXECUTABLE"
            Goto TheEnd
        ${EndIf}

        Rename "$USERPROFILEPATH\.lilypond-2.8.0-font.cache-1" "$DATADIRECTORY\.lilypond-2.8.0-font.cache-1"
        RMDir /r "$USERPROFILEPATH\.lilypond-2.8.0-font.cache-1"

        Rename "$USERPROFILEPATH\.lilypond-2.8.0-font.cache-1.BackupBy${NAME}" "$USERPROFILEPATH\.lilypond-2.8.0-font.cache-1"
        RMDir "$USERPROFILEPATH"

    TheEnd:
        newadvsplash::stop /WAIT
SectionEnd
