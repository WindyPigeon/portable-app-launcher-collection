${SegmentFile}

${SegmentPre}
    ${IfNot} ${FileExists} $DataDirectory\Preferences\kdenliverc
        CreateDirectory $DataDirectory\Preferences
        FileOpen    $0  $DataDirectory\Preferences\kdenliverc   w
        FileClose   $0

        WriteINIStr $DataDirectory\Preferences\kdenliverc   \
                env \
                customprojectfolder \
                true

        ReadEnvStr $0 PortableApps.comVideos:ForwardSlash
        WriteINIStr $DataDirectory\Preferences\kdenliverc   \
                env \
                defaultprojectfolder[$e]    \
                $0
    ${EndIf}
!macroend
