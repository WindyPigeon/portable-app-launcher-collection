${SegmentFile}

${SegmentPrePrimary}
    ${IfNot} ${FileExists} "$AppDirectory\IcoFX 2.0\portable"
        FileOpen $0 "$AppDirectory\IcoFX 2.0\portable" w
        FileClose $0
    ${EndIf}
!macroend
