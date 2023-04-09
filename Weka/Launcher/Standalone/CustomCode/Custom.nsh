${SegmentFile}

${SegmentPrePrimary}
    Rename "$PROFILE\wekafiles" "$PROFILE\wekafiles.BackupBy$AppID"

    ${GetRoot} "$DataDirectory\wekafiles" $0
    ${GetRoot} "$PROFILE\wekafiles" $1
    ${If} $0 == $1
        Rename "$DataDirectory\wekafiles" "$PROFILE\wekafiles"
    ${Else}
        CreateDirectory "$PROFILE\wekafiles"
        CopyFiles /SILENT "$DataDirectory\wekafiles\*.*" \
                "$PROFILE\wekafiles"
    ${EndIf}
!macroend

${SegmentPostPrimary}
    ClearErrors
    Rename "$PROFILE\wekafiles" "$DataDirectory\wekafiles"
    ${If} ${Errors}
        RMDir /r "$DataDirectory\wekafiles"
        CopyFiles /SILENT \
                "$PROFILE\wekafiles\*.*" \
                "$DataDirectory\wekafiles"
        RMDir /r "$PROFILE\wekafiles"
    ${EndIf}

    Rename "$PROFILE\wekafiles.BackupBy$AppID" "$PROFILE\wekafiles"

    RMDir "$PROFILE"
!macroend
