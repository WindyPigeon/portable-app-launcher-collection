${SegmentFile}

${SegmentPrePrimary}
    ${IfNot} ${FileExists} "$DataDirectory\settings\com.unity3d.UnityEditor5.x.reg"
        FileOpen $0 "$DataDirectory\settings\com.unity3d.UnityEditor5.x.reg" w
        FileWrite $0 "Windows Registry Editor Version 5.00$\r$\n\
                $\r$\n"
        FileClose $0

        ReadEnvStr $0 "PortableApps.comDocuments:ForwardSlash"
        WriteINIStr "$DataDirectory\settings\com.unity3d.UnityEditor5.x.reg" \
                "HKEY_CURRENT_USER\Software\Unity Technologies\Unity Editor 5.x" \
                '"kNewProjectsPath"' \
                '"$0/Unity Projects"'

        WriteINIStr "$DataDirectory\settings\com.unity3d.UnityEditor5.x.reg" \
                "HKEY_CURRENT_USER\Software\Unity Technologies\Unity Editor 5.x" \
                '"GICacheEnableCustomPath"' \
                "dword:00000001"

        ReadEnvStr $0 "PAL:DataDir:ForwardSlash"
        WriteINIStr "$DataDirectory\settings\com.unity3d.UnityEditor5.x.reg" \
                "HKEY_CURRENT_USER\Software\Unity Technologies\Unity Editor 5.x" \
                '"GICacheFolder"' \
                '"$0/Library/Caches/com.unity3d.UnityEditor/GiCache"'
    ${EndIf}

    Rename "$PROFILE\AppData\LocalLow\Unity\Editor" "$PROFILE\AppData\LocalLow\Unity\Editor.BackupBy$AppID"
    Rename "$PROFILE\AppData\LocalLow\Unity\Browser" "$PROFILE\AppData\LocalLow\Unity\Browser.BackupBy$AppID"

    ${GetRoot} "$DataDirectory\Library\Application Support\Unity\Editor" $0
    ${GetRoot} "$PROFILE\AppData\LocalLow\Unity\Editor" $1
    ${If} $0 == $1
        Rename "$DataDirectory\Library\Application Support\Unity\Editor" "$PROFILE\AppData\LocalLow\Unity\Editor"
    ${Else}
        CreateDirectory "$PROFILE\AppData\LocalLow\Unity\Editor"
        CopyFiles /SILENT \
                "$DataDirectory\Library\Application Support\Unity\Editor\*.*" \
                "$PROFILE\AppData\LocalLow\Unity\Editor"
    ${EndIf}

    Delete "$DataDirectory\Library\Logs\Unity\Editor-prev.log"
    Rename "$DataDirectory\Library\Logs\Unity\Editor.log" "$DataDirectory\Library\Logs\Unity\Editor-prev.log"

    ${GetRoot} "$DataDirectory\Library\Unity\Browser" $0
    ${GetRoot} "$PROFILE\AppData\LocalLow\Unity\Browser" $1
    ${If} $0 == $1
        Rename "$DataDirectory\Library\Unity\Browser" "$PROFILE\AppData\LocalLow\Unity\Browser"
    ${Else}
        CreateDirectory "$PROFILE\AppData\LocalLow\Unity\Browser"
        CopyFiles /SILENT "$DataDirectory\Library\Unity\Browser\*.*" \
                "$PROFILE\AppData\LocalLow\Unity\Browser"
    ${EndIf}
!macroend

${SegmentPostPrimary}
    ClearErrors
    Rename "$PROFILE\AppData\LocalLow\Unity\Browser" "$DataDirectory\Library\Unity\Browser"
    ${If} ${Errors}
        RMDir /r "$DataDirectory\Library\Unity\Browser"
        CreateDirectory "$DataDirectory\Library\Unity\Browser"
        CopyFiles /SILENT \
                "$PROFILE\AppData\LocalLow\Unity\Browser\*.*" \
                "$DataDirectory\Library\Unity\Browser"
        RMDir /r "$PROFILE\AppData\LocalLow\Unity\Browser"
    ${EndIf}

    ClearErrors
    Rename "$PROFILE\AppData\LocalLow\Unity\Editor" "$DataDirectory\Library\Application Support\Unity\Editor"
    ${If} ${Errors}
        RMDir /r "$DataDirectory\Library\Application Support\Unity\Editor"
        CreateDirectory "$DataDirectory\Library\Application Support\Unity\Editor"
        CopyFiles /SILENT \
                "$PROFILE\AppData\LocalLow\Unity\Editor\*.*" \
                "$DataDirectory\Library\Application Support\Unity\Editor"
        RMDir /r "$PROFILE\AppData\LocalLow\Unity\Editor"
    ${EndIf}

    Rename "$PROFILE\AppData\LocalLow\Unity\Editor.BackupBy$AppID" "$PROFILE\AppData\LocalLow\Unity\Editor"
    Rename "$PROFILE\AppData\LocalLow\Unity\Browser.BackupBy$AppID" "$PROFILE\AppData\LocalLow\Unity\Browser" 

    RMDir "$PROFILE\AppData\LocalLow\Unity"
    RMDir "$PROFILE\AppData\LocalLow"
    RMDir "$PROFILE\AppData"
    RMDir "$PROFILE"
!macroend
