${SegmentFile}

${SegmentPrePrimary}
    CreateDirectory "$AppDirectory\Arduino\portable"

    ${IfNot} ${FileExists} "$DataDirectory\Library\Arduino15\preferences.txt"
        CreateDirectory "$DataDirectory\Arduino15"
        FileOpen $0 "$DataDirectory\Library\Arduino15\preferences.txt" w
        ReadEnvStr $1 "PortableApps.comDocuments"
        CreateDirectory "$1\Arduino"
        FileWrite $0 "sketchbook.path=$1\Arduino"
        FileClose $0
    ${EndIf}
!macroend