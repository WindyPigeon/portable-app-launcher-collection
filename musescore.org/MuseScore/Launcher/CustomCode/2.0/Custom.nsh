${SegmentFile}

${SegmentPre}
    ${IfNot} ${FileExists} $DataDirectory\Library\Preferences\MuseScore2.ini
        CreateDirectory $DataDirectory\Library\Preferences

        FileOpen    $0  $DataDirectory\Library\Preferences\MuseScore2.ini   w
        FileWrite   $0  "[application]$\r$\n\
                $\r$\n\
                [General]$\r$\n\
                $\r$\n"
        FileClose   $0

        ReadEnvStr $0 PortableApps.comDocuments:ForwardSlash

        WriteINIStr $DataDirectory\Library\Preferences\MuseScore2.ini   \
                application \
                paths\myPlugins \
                $0/MuseScore4/Plugins

        WriteINIStr $DataDirectory\Library\Preferences\MuseScore2.ini   \
                application \
                paths\mySoundfonts  \
                $0/MuseScore4/SoundFonts

        WriteINIStr $DataDirectory\Library\Preferences\MuseScore2.ini   \
                application \
                paths\myStyles  \
                $0/MuseScore4/Styles

        WriteINIStr $DataDirectory\Library\Preferences\MuseScore2.ini   \
                application \
                paths\myTemplates  \
                $0/MuseScore4/Templates
    ${EndIf}
!macroend
