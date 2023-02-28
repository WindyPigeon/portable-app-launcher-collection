${SegmentFile}

${SegmentPrePrimary}
    ${IfNot} ${FileExists} "$DataDirectory\Library\Application Support\Metasequoia\Metaseq.ini"
        CreateDirectory "$DataDirectory\Library\Application Support\Metasequoia"
        FileOpen $0 "$DataDirectory\Library\Application Support\Metasequoia\Metaseq.ini" w
        FileClose $0
        WriteINIStr "$DataDirectory\Library\Application Support\Metasequoia\Metaseq.ini" \
                "System" \
                "BackupDir" \
                "$DataDirectory\Library\Application Support\Metasequoia\backup\"
    ${EndIf}
!macroend
