${SegmentFile}

${SegmentPreExecPrimary}
    Rename "$PROFILE\.gitconfig" "$PROFILE\.gitconfig.BackupBy$AppID"

    ClearErrors
    Rename "$DataDirectory\.gitconfig" "$PROFILE\.gitconfig"
    ${If} ${Errors}
        CreateDirectory "$PROFILE"
        CopyFiles /SILENT "$DataDirectory\.gitconfig" "$PROFILE"
    ${EndIf}
!macroend

${SegmentPostPrimary}
    ClearErrors
    Rename "$PROFILE\.gitconfig" "$DataDirectory\.gitconfig"
    ${If} ${Errors}
        Delete "$DataDirectory\.gitconfig"
        CopyFiles /SILENT "$PROFILE\.gitconfig" "$DataDirectory"
        Delete "$PROFILE\.gitconfig"
    ${EndIf}

    Rename "$PROFILE\.gitconfig.BackupBy$AppID" "$PROFILE\.gitconfig"

    RMDir "$PROFILE"
!macroend
