!addplugindir /x86-unicode ".\Plugins"

!ifndef VER_MAJOR
    !define VER_MAJOR "2020"
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
; SilentInstall Silent
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
!include MUI.nsh
!include nsDialogs.nsh

;(Custom)
!include ProcFunc.nsh
!include ReplaceInFileWithTextReplace.nsh

;=== Program Icon
Icon "..\..\App\AppInfo\appicon.ico"
; Icon "..\..\App\AppInfo\appicon_1.ico"

;=== Icon & Stye ===
!define MUI_ICON "..\..\App\AppInfo\appicon.ico"
; !define MUI_ICON "..\..\App\AppInfo\appicon_1.ico"
BrandingText "WindyPigeon"

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
Var SKIPOPTIONWINDOWS
Var PROJECTROOTDIRECTORY
Var PROJECTPATH
Var PROJECTCOMPANYNAME
Var PROJECTPRODUCTNAME
Var PROJECTAPPLICATIONIDENTIFIER
Var NEWPROJECTCOMPANYNAME
Var NEWPROJECTPRODUCTNAME
Var NEWPROJECTAPPLICATIONIDENTIFIER
Var SPACEREQUIREDHWND
Var SPACEAVAILABLEHWND

;=== Pages
InstType "createProject" IT_CREATE_PROJECT
InstType "openProject" IT_OPEN_PROJECT
;Options
Page custom OptionsPageShow
;Directory
SpaceTexts none
!define MUI_PAGE_HEADER_TEXT "Choose project folder"
!define MUI_PAGE_HEADER_SUBTEXT "Choose project folder"
!define MUI_DIRECTORYPAGE_TEXT_TOP "Choose project folder"
!define MUI_DIRECTORYPAGE_TEXT_DESTINATION "Choose project folder"
!define MUI_DIRECTORYPAGE_VARIABLE $PROJECTPATH
!define MUI_PAGE_CUSTOMFUNCTION_PRE PreDirectory
!define MUI_PAGE_CUSTOMFUNCTION_SHOW ShowDirectory
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES

;=== Languages
; LoadLanguageFile "${NSISDIR}\Contrib\Language files\${LAUNCHERLANGUAGE}.nlf"
!insertmacro MUI_LANGUAGE "English"
!include PortableApps.comLauncherLANG_${LAUNCHERLANGUAGE}.nsh

Function .onInit
	;=== Setup variables
        ;=== Get LOCALAPPDATA environment variable
        ReadEnvStr $LOCALAPPDATAPATH "LOCALAPPDATA"

        ;=== Determine current drive letter
        ${GetRoot} $EXEDIR $CURRENTDRIVE

        ;=== Determine PortableApps base directory
        ${GetParent} $EXEDIR $0
        ${GetParent} $0 $PORTABLEAPPSBASEDIRECTORY

        ;=== Determine PortableApps.com documents folder
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

        ;=== Get project folder
        ReadINIStr $PROJECTROOTDIRECTORY "$SETTINGSDIRECTORY\com.unity3d.UnityEditor5.x.reg" "HKEY_CURRENT_USER\Software\Unity Technologies\Unity Editor 5.x" '"kNewProjectsPath"'
        ${If} $PROJECTROOTDIRECTORY == ""
            StrCpy $PROJECTROOTDIRECTORY "$PORTABLEAPPS.COMDOCUMETSPATH\Unity Projects"
        ${EndIf}

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
        RMDir /r "$TEMP\${NAME}Live\"
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

    ; SetupExecString:
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

        ClearErrors
        ${GetOptions} "$EXECSTRING" "-createProject" $0
        ${If} ${Errors}
            ${GetOptions} "$EXECSTRING" "-projectPath" $0
            ${If} ${Errors}
                ${GetProcessPath} "Unity Hub.exe" $0
                ${If} $0 != 0
                ${AndIf} $EXEFILE == "Unity.exe"
                    Exec '"$0" -- --headless editors --add "$EXEDIR\$EXEFILE"'
                    MessageBox MB_YESNO "${UNITYVERSION} Portable , installed at $EXEDIR\$EXEFILE$\r$\n \
                            $\r$\n \
                            Unity Hub needs to be restarted for changes to take effect."

                    ${If} $RUNLOCALLY == true
                        RMDir /r "$TEMP\${NAME}Live"
                    ${EndIf}

                    Quit
                ${Else}
                    Goto LaunchOption
                ${EndIf}
            ${Else}
                SetCurInstType ${IT_OPEN_PROJECT}
                StrCpy $PROJECTPATH "$0"
                StrCpy $SKIPOPTIONWINDOWS true
            ${EndIf}
        ${ElseIf} $0 == ""
            MessageBox MB_OK|MB_ICONEXCLAMATION "Creating Project folder failed!"
            Goto LaunchOption
        ${Else}
            SetCurInstType ${IT_CREATE_PROJECT}
            StrCpy $PROJECTPATH "$0"
            ${GetBaseName} "$0" $PROJECTPRODUCTNAME
            StrCpy $PROJECTCOMPANYNAME "DefaultCompany"
            StrCpy $SKIPOPTIONWINDOWS true
        ${EndIf}

    LaunchOption:
FunctionEnd

Function OptionsPageShow
        ${If} $SKIPOPTIONWINDOWS == true
            Abort
        ${EndIf}

        ;=== Hide Install/Next Button and Cancel Button
        GetDlgItem $0 $HWNDPARENT 1
        ShowWindow $0 ${SW_HIDE}

        GetDlgItem $0 $HWNDPARENT 2
        ShowWindow $0 ${SW_HIDE}

        nsDialogs::Create 1018
        ${NSD_CreateLabel} 0 0 100% 90% "We recommend installing the Unity Hub for the best Unity experience$\r$\n \
                Visit http://unity3d.com/get-unity/download$\r$\n \
                $\r$\n \
                Continue launching Unity"
        ${NSD_CreateButton} 0 90% 30% 12u "Create empty project"
        Pop $0
        ${NSD_OnClick} $0 OnCreateProjectButtonClicked

        ${NSD_CreateButton} 33% 90% 30% 12u "Open project"
        Pop $0
        ${NSD_OnClick} $0 OnOpenProjectButtonClicked

        ${NSD_CreateButton} 66% 90% 30% 12u "Quit"
        Pop $0
        ${NSD_OnClick} $0 OnQuitButtonClicked

        nsDialogs::Show
FunctionEnd

Function OnCreateProjectButtonClicked
    SetCurInstType ${IT_CREATE_PROJECT}

    SendMessage $HWNDPARENT "0x408" 1 ""
FunctionEnd

Function OnOpenProjectButtonClicked
    SetCurInstType ${IT_OPEN_PROJECT}

    SendMessage $HWNDPARENT "0x408" 1 ""
FunctionEnd

Function OnQuitButtonClicked
    SendMessage $HWNDPARENT "0x408" 1 ""
    Quit
FunctionEnd

Function PreDirectory
    ${If} $SKIPOPTIONWINDOWS == true
        Abort
    ${EndIf}

    ${If} ${FileExists} "$SETTINGSDIRECTORY\com.unity3d.UnityEditor5.x.reg"
        FileOpen $0 "$SETTINGSDIRECTORY\com.unity3d.UnityEditor5.x.reg" r
        FileSeek $0 0
        StrCpy $2 ""
        ${Do}
            ClearErrors
            FileRead $0 $1
            ${If} $1 == ""
                ${TrimNewLines} $2 $2
                ${If} $2 == "[HKEY_CURRENT_USER\Software\Unity Technologies\Unity Editor 5.x]"
                    StrCpy $2 ""
                    ${Do}
                        ClearErrors
                        FileRead $0 $1
                        ${If} $1 == ""
                            ${TrimNewLines} $2 $2
                            StrCpy $2 ""
                        ${ElseIf} ${Errors}
                            ${ExitDo}
                        ${EndIf}
                        StrCpy $2 "$2$1"
                        ${If} $2 == '"RecentlyUsedProjectPaths-0_h1085040554"=hex:'
                            StrCpy $2 ""
                            ${Do}
                                ClearErrors
                                FileRead $0 $1
                                ${If} $1 == ""
                                    ${TrimNewLines} "$2" $2
                                    StrCpy $3 "$2" "" -1
                                    ${If} $3 == "\"
                                        StrCpy $2 "$2" -1
                                        ${Do}
                                            ClearErrors
                                            FileRead $0 $1
                                            ${TrimNewLines} "$1" $1
                                            ${If} $1 != " "
                                            ${AndIf} $1 != ""
                                                ${ExitDo}
                                            ${EndIf}
                                        ${Loop}
                                    ${Else}
                                        FileClose $0
                                        ${WordReplace} "$2" "," "" "+" $0
                                        ${Registry::HexToStr} "$0" $PROJECTPATH
                                        ${WordReplace} "$PROJECTPATH" "/" "\" "+" $PROJECTPATH
                                        Goto SetDefaultProjectLocation
                                    ${EndIf}
                                ${EndIf}

                                StrCpy $2 "$2$1"
                            ${Loop}
                        ${EndIf}
                    ${Loop}
                ${Else}
                    StrCpy $2 ""
                ${EndIf}
            ${ElseIf} ${Errors}
                ${ExitDo}
            ${EndIf}
            StrCpy $2 $2$1
        ${Loop}
    ${EndIf}

    SetDefaultProjectLocation:
        ;=== Set default location for project
        ${If} $PROJECTPATH == ""
            StrCpy $PROJECTPATH "$PROJECTROOTDIRECTORY\New Unity Project"
        ${EndIf}
FunctionEnd

Function ShowDirectory
    ;=== Show the next/install button and cancel button
    GetDlgItem $0 $HWNDPARENT 1
    ShowWindow $0 ${SW_SHOW}
    SendMessage $0 ${WM_SETTEXT} "" "STR:Select Folder"

    GetDlgItem $0 $HWNDPARENT 2
    ShowWindow $0 ${SW_SHOW}

    FindWindow $0 "#32770" "" $HWNDPARENT
    GetDlgItem $SPACEREQUIREDHWND $0 1023
    GetDlgItem $SPACEAVAILABLEHWND $0 1024

    ;=== Use the space required and space available text to show the directory validation errors
    SetCtlColors $SPACEREQUIREDHWND 0xFF0000 "transparent"
    SetCtlColors $SPACEAVAILABLEHWND 0xFF0000 "transparent"

    SendMessage $SPACEREQUIREDHWND ${WM_SETTEXT} "" "STR:A project with this name already exists at this"
    SendMessage $SPACEAVAILABLEHWND ${WM_SETTEXT} "" "STR:location"
    ShowWindow $SPACEREQUIREDHWND ${SW_SHOW}
    ShowWindow $SPACEAVAILABLEHWND ${SW_SHOW}
FunctionEnd

Function .onVerifyInstDir
    GetCurInstType $0
    ${If} $0 == ${IT_CREATE_PROJECT}
        FindFirst $0 $1 "$PROJECTPATH\*.*"
            FindNext $0 $1

            ClearErrors
            FindNext $0 $1
            ${If} ${Errors}
                Goto PathGood
            ${Else}
                ShowWindow $SPACEREQUIREDHWND ${SW_SHOW}
                ShowWindow $SPACEAVAILABLEHWND ${SW_SHOW}
                Abort
            ${EndIf}
        FindClose $0
    ${EndIf}

    PathGood:
        ShowWindow $SPACEREQUIREDHWND ${SW_HIDE}
        ShowWindow $SPACEAVAILABLEHWND ${SW_HIDE}
FunctionEnd

Section "Pre"
    SectionInstType ${IT_CREATE_PROJECT} ${IT_OPEN_PROJECT}
    HideWindow
SectionEnd

Section "CreateProject"
    SectionInstType ${IT_CREATE_PROJECT}
    StrCpy $EXECSTRING '$EXECSTRING -createProject "$PROJECTPATH"'
SectionEnd

Section "OpenProject"
    SectionInstType ${IT_OPEN_PROJECT}
    ${IfNot} ${FileExists} "$PROJECTPATH\Assets"
        MessageBox MB_OK|MB_ICONEXCLAMATION "There is no project in this folder"
        Quit
    ${EndIf}
    StrCpy $EXECSTRING '$EXECSTRING -projectPath "$PROJECTPATH"'
SectionEnd

Section "Main"
    SectionInstType ${IT_CREATE_PROJECT} ${IT_OPEN_PROJECT}

        ;=== Read the project settings
        ${If} ${FileExists} "$PROJECTPATH\ProjectSettings\ProjectSettings.asset"
            ${ConfigRead} "$PROJECTPATH\ProjectSettings\ProjectSettings.asset" "  companyName: " $PROJECTCOMPANYNAME
            ${If} $PROJECTCOMPANYNAME != ""
                StrCpy $PROJECTCOMPANYNAME "DefaultCompany"
            ${EndIf}

            ${ConfigRead} "$PROJECTPATH\ProjectSettings\ProjectSettings.asset" "  productName: " $PROJECTPRODUCTNAME
            ${If} $PROJECTPRODUCTNAME != ""
                ${GetBaseName} "$PROJECTPATH" $PROJECTPRODUCTNAME
            ${EndIf}

            ClearErrors
            ${ConfigRead} "$PROJECTPATH\ProjectSettings\ProjectSettings.asset" "    Standalone: " $PROJECTAPPLICATIONIDENTIFIER
            ${If} ${Errors}
                StrCpy $PROJECTAPPLICATIONIDENTIFIER "com.$PROJECTCOMPANYNAME.$PROJECTPRODUCTNAME"
                ${WordReplace} $PROJECTAPPLICATIONIDENTIFIER " " "" "+" $PROJECTAPPLICATIONIDENTIFIER
            ${ElseIf} $PROJECTAPPLICATIONIDENTIFIER == ""
                StrCpy $PROJECTAPPLICATIONIDENTIFIER "$PROJECTPRODUCTNAME"
            ${EndIf}
        ${EndIf}

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

        ReadINIStr $LASTPORTABLEAPPSBASEDIRECTORY "$EXEDIR\Data\settings\${AppID}Settings.ini" "LastRunEnvironment" "LastPortableAppsBaseDir"
        ${If} $LASTPORTABLEAPPSBASEDIRECTORY != $PORTABLEAPPSBASEDIRECTORY
            WriteINIStr "$EXEDIR\Data\settings\${AppID}Settings.ini" "LastRunEnvironment" "LastPortableAppsBaseDir" $PORTABLEAPPSBASEDIRECTORY
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
        ;=== Backup original editor preferences and REST certificate
        Rename "$APPDATA\Unity" "$APPDATA\Unity.BackupBy${NAME}"

        ;=== Backup original local app data
        ;=== Backup original config and logs of Plastic
        Rename "$LOCALAPPDATA\plastic4" "$LOCALAPPDATA\plastic4.BackupBy${NAME}"

        ;=== Backup original logs and cache
        Rename "$LOCALAPPDATA\Unity" "$LOCALAPPDATA\Unity.BackupBy${NAME}"
        ${If} "$LOCALAPPDATA" != "$LOCALAPPDATAPATH"
            Rename "$LOCALAPPDATAPATH\Unity" "$LOCALAPPDATAPATH\Unity.BackupBy${NAME}"
        ${EndIf}

        ;=== Backup original local low app data
        ;=== Backup original browser cache and cookies and original editor value, config and archived events
        Rename "$PROFILE\AppData\LocalLow\Unity" "$PROFILE\AppData\LocalLow\Unity.BackupBy${NAME}"

        ;=== Backup original project logs
        Rename "$PROFILE\AppData\LocalLow\$PROJECTCOMPANYNAME\$PROJECTPRODUCTNAME" "$PROFILE\AppData\LocalLow\$PROJECTCOMPANYNAME\$PROJECTPRODUCTNAME.BackupBy${NAME}"

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

        ;=== Restore the production and user services config
        ${GetRoot} "$DATADIRECTORY\Library\Unity\config" $0
        ${GetRoot} "$LOCALAPPDATA\Unity\config" $1
        ${If} $0 == $1
            Rename "$DATADIRECTORY\Library\Unity\config" "$LOCALAPPDATA\Unity\config"
        ${Else}
            CreateDirectory "$LOCALAPPDATA\Unity\config"
            CopyFiles /SILENT "$DATADIRECTORY\Library\Unity\config\*.*" "$LOCALAPPDATA\Unity\config"
        ${EndIf}

        ;=== Restore the REST certificate
        Rename "$DATADIRECTORY\Library\Unity\rest-certificate.pem" "$APPDATA\Unity\rest-certificate.pem"
        ${If} ${Errors}
            CreateDirectory "$APPDATA\Unity"
            CopyFiles /SILENT "$DATADIRECTORY\Library\Unity\rest-certificate.pem" "$APPDATA\Unity"
        ${EndIf}

        ;=== Restore the config and logs of Plastic
        ${GetRoot} "$DATADIRECTORY\.plastic4" $0
        ${GetRoot} "$LOCALAPPDATA\plastic4" $1
        ${If} $0 == $1
            Rename "$DATADIRECTORY\.plastic4" "$LOCALAPPDATA\plastic4"
        ${Else}
            CreateDirectory "$LOCALAPPDATA\plastic4"
            CopyFiles /SILENT "$DATADIRECTORY\.plastic4\*.*" "$LOCALAPPDATA\plastic4"
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

        ${registry::KeyExists} "HKEY_CURRENT_USER\Software\$PROJECTCOMPANYNAME\$PROJECTPRODUCTNAME" $0
        ${If} $0 != -1
            ${registry::MoveKey} "HKEY_CURRENT_USER\Software\$PROJECTCOMPANYNAME\$PROJECTPRODUCTNAME" "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\$PROJECTCOMPANYNAME\$PROJECTPRODUCTNAME" $0
        ${EndIf}

    ; RestoreTheKey:
        ${registry::RestoreKey} "$SETTINGSDIRECTORY\com.unity3d.UnityEditor5.x.reg" $0

    ; DisplaySplash:
        StrCmp $DISABLESPLASHSCREEN "true" SkipSplashScreen
            ; === Show the splash screen before processing the files
            InitPluginsDir
            newadvsplash::show /NOUNLOAD 2000 0 0 -1 /L "$EXEDIR\App\AppInfo\Launcher\splash.jpg"

    SkipSplashScreen:
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

        ;=== Check for changes in project settings
        ${If} ${FileExists} "$PROJECTPATH\ProjectSettings\ProjectSettings.asset"
            ${ConfigRead} "$PROJECTPATH\ProjectSettings\ProjectSettings.asset" "  companyName: " $NEWPROJECTCOMPANYNAME
            ${If} $NEWPROJECTCOMPANYNAME != ""
                StrCpy $NEWPROJECTCOMPANYNAME "DefaultCompany"
            ${EndIf}

            ${ConfigRead} "$PROJECTPATH\ProjectSettings\ProjectSettings.asset" "  productName: " $NEWPROJECTPRODUCTNAME
            ${If} $NEWPROJECTPRODUCTNAME != ""
                ${GetBaseName} "$PROJECTPATH" $NEWPROJECTPRODUCTNAME
            ${EndIf}

            ClearErrors
            ${ConfigRead} "$PROJECTPATH\ProjectSettings\ProjectSettings.asset" "    Standalone: " $PROJECTAPPLICATIONIDENTIFIER
            ${If} ${Errors}
                StrCpy $NEWPROJECTAPPLICATIONIDENTIFIER "com.$NEWPROJECTCOMPANYNAME.$NEWPROJECTPRODUCTNAME"
                ${WordReplace} $NEWPROJECTAPPLICATIONIDENTIFIER " " "" "+" $NEWPROJECTAPPLICATIONIDENTIFIER
            ${ElseIf} $NEWPROJECTAPPLICATIONIDENTIFIER == ""
                StrCpy $NEWPROJECTAPPLICATIONIDENTIFIER "$NEWPROJECTPRODUCTNAME"
            ${EndIf}
        ${EndIf}

    ; SaveRegistry:
        ${registry::SaveKey} "HKEY_CURRENT_USER\Software\Unity Technologies\Unity Editor 5.x" "$SETTINGSDIRECTORY\com.unity3d.UnityEditor5.x.reg" "" $0
        ${registry::SaveKey} "HKEY_CURRENT_USER\Software\Unity\UnityEditor\$NEWPROJECTCOMPANYNAME\$NEWPROJECTPRODUCTNAME" "$SETTINGSDIRECTORY\unity.$NEWPROJECTCOMPANYNAME.$NEWPROJECTPRODUCTNAME.reg" "" $0
        ${registry::SaveKey} "HKEY_CURRENT_USER\Software\$NEWPROJECTCOMPANYNAME\$NEWPROJECTPRODUCTNAME" "$SETTINGSDIRECTORY\$NEWPROJECTAPPLICATIONIDENTIFIER.reg" "" $0

        ${If} "$PROJECTCOMPANYNAME" != "$NEWPROJECTCOMPANYNAME"
        ${OrIf} "$PROJECTPRODUCTNAME" != "$NEWPROJECTPRODUCTNAME"
            ${registry::SaveKey} "HKEY_CURRENT_USER\Software\Unity\UnityEditor\$PROJECTCOMPANYNAME\$PROJECTPRODUCTNAME" "$SETTINGSDIRECTORY\unity.$PROJECTCOMPANYNAME.$PROJECTPRODUCTNAME.reg" "" $0
            ${registry::SaveKey} "HKEY_CURRENT_USER\Software\$PROJECTCOMPANYNAME\$PROJECTPRODUCTNAME" "$SETTINGSDIRECTORY\$PROJECTAPPLICATIONIDENTIFIER.reg" "" $0
        ${EndIf}

    ; CleanupRegistry:
        ${registry::DeleteKey} "HKEY_CURRENT_USER\Software\Unity Technologies\Unity Editor 5.x" $0
        ${registry::DeleteKey} "HKEY_CURRENT_USER\Software\Unity\UnityEditor" $0
        ${registry::DeleteKey} "HKEY_CURRENT_USER\Software\$NEWPROJECTCOMPANYNAME\$NEWPROJECTPRODUCTNAME" $0
        ${registry::DeleteKey} "HKEY_CURRENT_USER\Software\$PROJECTCOMPANYNAME\$PROJECTPRODUCTNAME" $0

    ; SetOriginalKeyBack:
        ${registry::MoveKey} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\Unity Technologies\Unity Editor 5.x" "HKEY_CURRENT_USER\Software\Unity Technologies\Unity Editor 5.x" $0
        ${registry::MoveKey} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\Unity\UnityEditor" "HKEY_CURRENT_USER\Software\Unity\UnityEditor" $0
        ${registry::MoveKey} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\$PROJECTCOMPANYNAME\$PROJECTPRODUCTNAME" "HKEY_CURRENT_USER\Software\$PROJECTCOMPANYNAME\$PROJECTPRODUCTNAME" $0

        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\Unity Technologies\Unity Editor 5.x" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\Unity Technologies" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\Unity\UnityEditor\$PROJECTCOMPANYNAME" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\Unity\UnityEditor\$NEWPROJECTCOMPANYNAME" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\Unity\UnityEditor" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\Unity" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\$PROJECTCOMPANYNAME" $0

        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\Unity Technologies\Unity Editor 5.x" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\Unity Technologies" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\Unity\UnityEditor\$PROJECTCOMPANYNAME" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\Unity\UnityEditor" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\Unity" $0
        ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\$PROJECTCOMPANYNAME" $0
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

        ;=== Move the production and user services config back
        ClearErrors
        Rename "$LOCALAPPDATA\Unity\config" "$DATADIRECTORY\Library\Unity\config"
        ${If} ${Errors}
            RMDir /r "$DATADIRECTORY\Library\Unity\config"
            CreateDirectory "$DATADIRECTORY\Library\Unity\config"
            CopyFiles /SILENT "$LOCALAPPDATA\Unity\config\*.*" "$DATADIRECTORY\Library\Unity\config"
            RMDir /r "$LOCALAPPDATA\Unity\config"
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

        ;=== Save Unity.Entitlements.Audit.log and Unity.Licensing.Client.log
        Rename "$LOCALAPPDATA\Unity" "$DATADIRECTORY\Library\Logs\Unity"
        ${If} ${Errors}
            Delete "$DATADIRECTORY\Library\Logs\Unity\Unity.Entitlements.Audit.log"
            Delete "$DATADIRECTORY\Library\Logs\Unity\Unity.Licensing.Client.log"
            CreateDirectory "$DATADIRECTORY\Library\Logs\Unity"
            CopyFiles /SILENT "$LOCALAPPDATA\Unity\*.*" "$DATADIRECTORY\Library\Logs\Unity"
            RMDir /r "$LOCALAPPDATA\Unity"
        ${EndIf}

        ;=== Move the config and logs of Plastic back
        Rename "$LOCALAPPDATA\plastic4" "$DATADIRECTORY\.plastic4"
        ${If} ${Errors}
            RMDir /r "$DATADIRECTORY\.plastic4"
            CreateDirectory "$DATADIRECTORY\.plastic4"
            CopyFiles /SILENT "$LOCALAPPDATA\plastic4\*.*" "$DATADIRECTORY\.plastic4"
            RMDir /r "$LOCALAPPDATA\plastic4"
        ${EndIf}

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

        ;=== Move the CoreBusinessMetrics.db back
        ClearErrors
        Rename "$PROFILE\AppData\LocalLow\Unity" "$DATADIRECTORY\Library\Application Support\Unity"
        ${If} ${Errors}
            Delete "$DATADIRECTORY\Library\Application Support\Unity\CoreBusinessMetrics.db"
            Delete "$DATADIRECTORY\Library\Application Support\Unity\CoreBusinessMetrics.db-shm"
            Delete "$DATADIRECTORY\Library\Application Support\Unity\CoreBusinessMetrics.db-wal"
            CreateDirectory "$DATADIRECTORY\Library\Application Support\Unity"
            CopyFiles /SILENT "$PROFILE\AppData\LocalLow\Unity\*.*" "$DATADIRECTORY\Library\Application Support\Unity"
            RMDir /r "$PROFILE\AppData\LocalLow\Unity"
        ${EndIf}

        ;=== Move the project config and logs back
        ClearErrors
        Rename "$PROFILE\AppData\LocalLow\$PROJECTCOMPANYNAME\$PROJECTPRODUCTNAME" "$DATADIRECTORY\Library\Logs\$PROJECTCOMPANYNAME\$PROJECTPRODUCTNAME"
        ${If} ${Errors}
            Delete "$DATADIRECTORY\Library\Logs\$PROJECTCOMPANYNAME\$PROJECTPRODUCTNAME\Player.log"
            CreateDirectory "$DATADIRECTORY\Library\Logs\$PROJECTCOMPANYNAME\$PROJECTPRODUCTNAME"
            CopyFiles /SILENT "$PROFILE\AppData\LocalLow\$PROJECTCOMPANYNAME\$PROJECTPRODUCTNAME\*.*" "$DATADIRECTORY\Library\Logs\$PROJECTCOMPANYNAME\$PROJECTPRODUCTNAME"
            RMDir /r "$PROFILE\AppData\LocalLow\$PROJECTCOMPANYNAME\$PROJECTPRODUCTNAME"
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
        Rename "$LOCALAPPDATA\plastic4.BackupBy${NAME}" "$LOCALAPPDATA\plastic4"

        Rename "$PROFILE\AppData\LocalLow\Unity.BackupBy${NAME}" "$PROFILE\AppData\LocalLow\Unity"
        Rename "$PROFILE\AppData\LocalLow\$PROJECTCOMPANYNAME\$PROJECTPRODUCTNAME.BackupBy${NAME}" "$PROFILE\AppData\LocalLow\$PROJECTCOMPANYNAME\$PROJECTPRODUCTNAME"

        Rename "$COMMONPROGRAMDATA\Unity.BackupBy${NAME}" "$COMMONPROGRAMDATA\Unity"

        ;=== Remove empty folders
        RMDir "$APPDATA\Unity\Editor-5.x"
        RMDir "$APPDATA\Unity"
        RMDir "$APPDATA"
        RMDir "$LOCALAPPDATA\plastic4"
        RMDir "$LOCALAPPDATA\Unity"
        RMDir "$LOCALAPPDATA"
        RMDir "$LOCALAPPDATAPATH\Unity"
        RMDir "$LOCALAPPDATAPATH"
        RMDir "$PROFILE\AppData\LocalLow\Unity"
        RMDir "$PROFILE\AppData\LocalLow\$NEWPROJECTCOMPANYNAME\$NEWPROJECTPRODUCTNAME"
        RMDir "$PROFILE\AppData\LocalLow\$NEWPROJECTCOMPANYNAME"
        RMDir "$PROFILE\AppData\LocalLow\$PROJECTCOMPANYNAME\$PROJECTPRODUCTNAME"
        RMDir "$PROFILE\AppData\LocalLow\$PROJECTCOMPANYNAME"
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
