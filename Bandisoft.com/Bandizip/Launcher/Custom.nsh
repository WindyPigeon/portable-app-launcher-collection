${SegmentFile}

Var BANDIZIPDIRECTORY
Var BANDIZIPBASENAME

${SegmentPrePrimary}
    ${GetParent} "$AppDirectory\$ProgramExecutable" $BANDIZIPDIRECTORY
    ${GetBaseName} "$ProgramExecutable" $BANDIZIPBASENAME

    ${IfNot} ${FileExists} "$BANDIZIPDIRECTORY\config.ini"
        FileOpen $0 "$BANDIZIPDIRECTORY\config.ini" w
        FileClose $0
    ${EndIf}
    WriteINIStr "$BANDIZIPDIRECTORY\config.ini" "setting" "is_portable" "1"

    ${IfNot} ${FileExists} "$DataDirectory\settings\com.bandisoft.bandizip.ini"
        FileOpen $0 "$DataDirectory\settings\com.bandisoft.bandizip.ini" w
        FileClose $0

        ReadEnvStr $0 "PortableApps.comDocuments"
        WriteINIStr "$DataDirectory\settings\com.bandisoft.bandizip.ini" "setting" "shellOpenOprTargetPath " " $0\ "
        WriteINIStr "$DataDirectory\settings\com.bandisoft.bandizip.ini" "setting" "newArchiveDefaultPath " " $0\"
        WriteINIStr "$DataDirectory\settings\com.bandisoft.bandizip.ini" "setting" "sSplitDestFolder " " $0\"
        WriteINIStr "$DataDirectory\settings\com.bandisoft.bandizip.ini" "setting" "sEncryptDestFolder " " $0\"
    ${EndIf}

    ${IfNot} ${FileExists} "$BANDIZIPDIRECTORY\$BANDIZIPBASENAME.ini-BackupBy$AppID"
        Rename "$BANDIZIPDIRECTORY\$BANDIZIPBASENAME.ini" "$BANDIZIPDIRECTORY\$BANDIZIPBASENAME.ini-BackupBy$AppID"
    ${EndIf}

    Rename "$DataDirectory\settings\com.bandisoft.bandizip.ini" "$BANDIZIPDIRECTORY\$BANDIZIPBASENAME.ini"
!macroend

${SegmentPostPrimary}
    Rename "$BANDIZIPDIRECTORY\$BANDIZIPBASENAME.ini" "$DataDirectory\settings\com.bandisoft.bandizip.ini"
    Rename "$BANDIZIPDIRECTORY\$BANDIZIPBASENAME.ini-BackupBy$AppID" "$BANDIZIPDIRECTORY\$BANDIZIPBASENAME.ini"
!macroend
