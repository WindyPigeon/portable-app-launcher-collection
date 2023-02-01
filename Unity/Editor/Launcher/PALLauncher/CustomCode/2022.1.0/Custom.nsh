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

        WriteINIStr "$SETTINGSDIRECTORY\com.unity3d.UnityEditor5.x.reg" \
                "HKEY_CURRENT_USER\Software\Unity Technologies\Unity Editor 5.x" \
                '"AssetStoreCacheRootPath"' \
                '"$0/Library/Unity"'
    ${EndIf}

    ${IfNot} ${FileExists} "$DataDirectory\.upmconfig.toml"
        FileOpen $0 "$DataDirectory\.upmconfig.toml" w
        FileClose $0

        CreateDirectory "$DataDirectory\Library\Unity\cache"
        ReadEnvStr $0 "PAL:DataDir:DoubleBackslash"
        ${ConfigWrite} "$DataDirectory\.upmconfig.toml" \
                "cacheRoot = " \
                '"$0\\Library\\Unity\\cache"' \
                $0
    ${EndIf}

    Rename "$PROFILE\AppData\LocalLow\Unity" "$PROFILE\AppData\LocalLow\Unity.BackupBy$AppID"

    ${GetRoot} "$DataDirectory\Library\Application Support\Unity" $0
    ${GetRoot} "$PROFILE\AppData\LocalLow\Unity" $1
    ${If} $0 == $1
        Rename "$DataDirectory\Library\Application Support\Unity\CoreBusinessMetrics.db" "$PROFILE\AppData\LocalLow\Unity\CoreBusinessMetrics.db"
        Rename "$DataDirectory\Library\Application Support\Unity\CoreBusinessMetrics.db-shm" "$PROFILE\AppData\LocalLow\Unity\CoreBusinessMetrics.db-shm"
        Rename "$DataDirectory\Library\Application Support\Unity\CoreBusinessMetrics.db-wal" "$PROFILE\AppData\LocalLow\Unity\CoreBusinessMetrics.db-wal"
    ${Else}
        CreateDirectory "$PROFILE\AppData\LocalLow\Unity"
        CopyFiles /SILENT \
                "$DataDirectory\Library\Application Support\Unity\CoreBusinessMetrics.db" \
                "$PROFILE\AppData\LocalLow\Unity"
        CopyFiles /SILENT \
                "$DataDirectory\Library\Application Support\Unity\CoreBusinessMetrics.db-shm" \
                "$PROFILE\AppData\LocalLow\Unity"
        CopyFiles /SILENT \
                "$DataDirectory\Library\Application Support\Unity\CoreBusinessMetrics.db-wal" \
                "$PROFILE\AppData\LocalLow\Unity"
    ${EndIf}
!macroend

${SegmentPostPrimary}
    ClearErrors
    Rename "$PROFILE\AppData\LocalLow\Unity" "$DataDirectory\Library\Application Support\Unity"
    ${If} ${Errors}
        RMDir /r "$DataDirectory\Library\Application Support\Unity"
        CreateDirectory "$DataDirectory\Library\Application Support\Unity"
        CopyFiles /SILENT \
                "$PROFILE\AppData\LocalLow\Unity\*.*" \
                "$DataDirectory\Library\Application Support\Unity"
        RMDir /r "$PROFILE\AppData\LocalLow\Unity"
    ${EndIf}

    Rename "$PROFILE\AppData\LocalLow\Unity.BackupBy$AppID" "$PROFILE\AppData\LocalLow\Unity"

    RMDir "$PROFILE\AppData\LocalLow\Unity\Editor"
    RMDir "$PROFILE\AppData\LocalLow\Unity\Browser"
    RMDir "$PROFILE\AppData\LocalLow\Unity"
    RMDir "$PROFILE\AppData\LocalLow"
    RMDir "$PROFILE\AppData"
    RMDir "$PROFILE"
!macroend
