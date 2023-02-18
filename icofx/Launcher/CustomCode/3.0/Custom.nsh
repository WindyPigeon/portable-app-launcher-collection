${SegmentFile}

${SegmentPrePrimary}
    ${IfNot} ${FileExists} "$AppDirectory\icofx3\portable"
        FileOpen $0 "$AppDirectory\icofx3\portable" w
        FileClose $0
    ${EndIf}
!macroend
