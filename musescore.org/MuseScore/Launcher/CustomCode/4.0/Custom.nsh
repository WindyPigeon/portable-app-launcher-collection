${SegmentFile}

${SegmentPre}
    ${IfNot} ${FileExists} $DataDirectory\Preferences\MuseScore4.ini
        CreateDirectory $DataDirectory\Preferences

        FileOpen    $0  $DataDirectory\Preferences\MuseScore4.ini   w
        FileWrite   $0  "[application]$\r$\n\
                $\r$\n\
                [General]$\r$\n\
                $\r$\n"
        FileClose   $0

        ReadEnvStr $0 PortableApps.comDocuments:ForwardSlash

        WriteINIStr $DataDirectory\Preferences\MuseScore4.ini   \
                application \
                paths\myPlugins \
                $0/MuseScore4/Plugins

        WriteINIStr $DataDirectory\Preferences\MuseScore4.ini   \
                application \
                paths\mySoundfonts  \
                $0/MuseScore4/SoundFonts

        WriteINIStr $DataDirectory\Preferences\MuseScore4.ini   \
                application \
                paths\myStyles  \
                $0/MuseScore4/Styles

        WriteINIStr $DataDirectory\Preferences\MuseScore4.ini   \
                application \
                paths\myTemplates  \
                $0/MuseScore4/Templates
    ${EndIf}
!macroend