${SegmentFile}

${SegmentPre}
    ${IfNot} ${FileExists} "$DataDirectory\Library\Preferences\MuseScore.ini"
        CreateDirectory "$DataDirectory\Library\Preferences"

        FileOpen $0 "$DataDirectory\Library\Preferences\MuseScore.ini" w
        FileWrite $0 "[application]$\r$\n\
                $\r$\n\
                [General]$\r$\n\
                $\r$\n"
        FileClose $0

        ReadEnvStr $0 "PortableApps.comDocuments:ForwardSlash"
        WriteINIStr "$DataDirectory\Library\Preferences\MuseScore.ini" \
                "application" \
                "paths\myPlugins" \
                "$0/MuseScore/Plugins"                                                
        WriteINIStr "$DataDirectory\Library\Preferences\MuseScore.ini" \
                "application" \
                "paths\mySoundfonts" \
                "$0/MuseScore/SoundFonts"
        WriteINIStr "$DataDirectory\Library\Preferences\MuseScore.ini" \
                "application" \
                "paths\myStyles" \
                "$0/MuseScore/Styles"
        WriteINIStr "$DataDirectory\Library\Preferences\MuseScore.ini" \
                "application" \
                "paths\myTemplates" \
                "$0/MuseScore/Templates"
    ${EndIf}
!macroend
