${SegmentFile}

Var PACEAPDATADIRECTORY

${SegmentPrePrimary}
    ${If} ${FileExists} "$COMMONPROGRAMDATA"
            StrCpy $PACEAPDATADIRECTORY "$COMMONPROGRAMDATA"
     ${ElseIf} ${FileExists} "$APPDATA"
            StrCpy $PACEAPDATADIRECTORY "$APPDATA"
    ${ElseIf} ${AtLeastWinVista}
            StrCpy $PACEAPDATADIRECTORY "$PROFILE\AppData\Local\VirtualStore\Program Files (x86)\Common Files"
    ${Else}
            StrCpy $PACEAPDATADIRECTORY "$COMMONFILES"
    ${EndIf}

    Rename "$PACEAPDATADIRECTORY\PACE Anti-Piracy\License Files" "$PACEAPDATADIRECTORY\PACE Anti-Piracy\License Files.BackupBy$AppID"

    ${GetRoot} "$DataDirectory\Library\Application Support\PACE Anti-Piracy\License Files" $0
    ${GetRoot} "$PACEAPDATADIRECTORY\PACE Anti-Piracy\License Files" $1
    ${If} "$0" == "$1"
        Rename "$DataDirectory\Library\Application Support\PACE Anti-Piracy\License Files" "$PACEAPDATADIRECTORY\PACE Anti-Piracy\License Files"
    ${Else}
        CreateDirectory "$PACEAPDATADIRECTORY\PACE Anti-Piracy\License Files"
        CopyFiles /SILENT \
                "$DataDirectory\Library\Application Support\PACE Anti-Piracy\License Files\*.*" \
                "$PACEAPDATADIRECTORY\PACE Anti-Piracy\License Files"
    ${EndIf}

    Delete "$DataDirectory\Library\Logs\Unity\Editor-prev.log"
    Rename "$DataDirectory\Library\Logs\Unity\Editor.log" "$DataDirectory\Library\Logs\Unity\Editor-prev.log"

    ${registry::MoveKey} "HKEY_CURRENT_USER\Software\Unity\UnityEditor" \
            "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\Unity\UnityEditor" \
            $0
!macroend

${SegmentPostPrimary}
    ${registry::SaveKey} "HKEY_CURRENT_USER\Software\Unity\UnityEditor" \
            "$DataDirectory\settings\com.unity3d.UnityEditor.reg" \
            "/A=1 /G=0" \
            $0

    ${registry::DeleteKey} "HKEY_CURRENT_USER\Software\Unity\UnityEditor" $0

    ${registry::MoveKey} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\Unity\UnityEditor" \
            "HKEY_CURRENT_USER\Software\Unity\UnityEditor" \
            $0

    ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\Unity\UnityEditor" $0
    ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\Unity" $0

    ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\Unity\UnityEditor" $0
    ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software\Unity" $0
    ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU\Software" $0
    ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKCU" $0
    ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys" $0
    ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com" $0

    ClearErrors
    Rename "$PACEAPDATADIRECTORY\PACE Anti-Piracy\License Files" "$DataDirectory\Library\Application Support\PACE Anti-Piracy\License Files"
    ${If} ${Errors}
        RMDir /r "$DataDirectory\Library\Application Support\PACE Anti-Piracy\License Files"
        CreateDirectory "$DataDirectory\Library\Application Support\PACE Anti-Piracy\License Files"
        CopyFiles /SILENT \
                "$PACEAPDATADIRECTORY\PACE Anti-Piracy\License Files\*.*" \
                "$DataDirectory\Library\Application Support\PACE Anti-Piracy\License Files"
        RMDir /r "$PACEAPDATADIRECTORY\PACE Anti-Piracy\License Files"
    ${EndIf}
    
    Rename "$PACEAPDATADIRECTORY\PACE Anti-Piracy\License Files.BackupBy$AppID" "$PACEAPDATADIRECTORY\PACE Anti-Piracy\License Files"

    RMDir "$APPDATA\PACE Anti-Piracy"
    RMDir "$APPDATA"
    RMDir "$LOCALAPPDATA\PACE Anti-Piracy"
    RMDir "$LOCALAPPDATA"
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
    RMDir "$COMMONPROGRAMDATA\PACE Anti-Piracy"
!macroend
