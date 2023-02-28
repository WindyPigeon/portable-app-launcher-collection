${SegmentFile}

${SegmentPrePrimary}
    ${IfNot} ${FileExists} "$DataDirectory\Library\Application Support\MetasequoiaLE\Metaseq.ini"
        CreateDirectory "$DataDirectory\Library\Application Support\MetasequoiaLE"
        FileOpen $0 "$DataDirectory\Library\Application Support\MetasequoiaLE\Metaseq.ini" w
        FileClose $0
        WriteINIStr "$DataDirectory\Library\Application Support\MetasequoiaLE\Metaseq.ini" \
                "System" \
                "BackupDir" \
                "$DataDirectory\Library\Application Support\MetasequoiaLE\backup\"
    ${EndIf}
!macroend
