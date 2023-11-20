${SegmentFile}

${SegmentPre}
    ${IfNot} ${FileExists} "$DataDirectory\Library\Preferences\MuseScore3.ini"
        CreateDirectory "$DataDirectory\Library\Preferences"

        FileOpen $0 "$DataDirectory\Library\Preferences\MuseScore3.ini" w
        FileWrite $0 "[application]$\r$\n\
                $\r$\n\
                [General]$\r$\n\
                $\r$\n"
        FileClose $0

        ReadEnvStr $0 "PortableApps.comDocuments:ForwardSlash"

        WriteINIStr "$DataDirectory\Library\Preferences\MuseScore3.ini" \
                "application" \
                "paths\myScores" \
                "$0/MuseScore3/Scores"

        WriteINIStr "$DataDirectory\Library\Preferences\MuseScore3.ini" \
                "application" \
                "paths\myStyles" \
                "$0/MuseScore3/Styles"

        WriteINIStr "$DataDirectory\Library\Preferences\MuseScore3.ini" \
                "application" \
                "paths\myImages" \
                "$0/MuseScore3/Images"

        WriteINIStr "$DataDirectory\Library\Preferences\MuseScore3.ini" \
                "application" \
                "paths\myTemplates" \
                "$0/MuseScore3/Templates"

        WriteINIStr "$DataDirectory\Library\Preferences\MuseScore3.ini" \
                "application" \
                "paths\myPlugins" \
                "$0/MuseScore3/Plugins"

        WriteINIStr "$DataDirectory\Library\Preferences\MuseScore3.ini" \
                "application" \
                "paths\mySoundfonts" \
                "$0/MuseScore3/SoundFonts"

        WriteINIStr "$DataDirectory\Library\Preferences\MuseScore3.ini" \
                "application" \
                "paths\myExtensions" \
                "$0/MuseScore3/Extensions"
    ${EndIf}
!macroend

${SegmentPrePrimary}
    CreateDirectory "$DataDirectory\Library\Application Support\MuseScore\MuseScore3"
!macroend
