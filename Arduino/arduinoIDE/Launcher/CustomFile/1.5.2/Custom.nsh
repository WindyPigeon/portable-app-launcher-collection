${SegmentFile}

${SegmentPrePrimary}
    CreateDirectory $AppDirectory\Arduino\portable

    ${IfNot} ${FileExists} $DataDirectory\Library\Arduino\preferences.txt
        CreateDirectory $DataDirectory\Arduino
        FileOpen    $0  $DataDirectory\Library\Arduino\preferences.txt  w
        
        ReadEnvStr  $1  PortableApps.comDocuments
        CreateDirectory $1\Arduino
        FileWrite   $0  `sketchbook.path=$1\Arduino`

        FileClose   $0
    ${EndIf}
!macroend