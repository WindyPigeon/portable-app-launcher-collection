${SegmentFile}

${SegmentPrePrimary}
    ${IfNot} ${FileExists} "$DataDirectory\.arduinoProIDE\arduino-cli.yaml"
        CreateDirectory "$DataDirectory\.arduinoProIDE"
        FileOpen $0 "$DataDirectory\.arduinoProIDE\arduino-cli.yaml" w
        FileWrite $0 "directories:$\r$\n"
        FileWrite $0 "  builtin:$\r$\n"
        FileWrite $0 "    libraries: $DataDirectory\Library\Arduino15\libraries$\r$\n"
        FileWrite $0 "  data: $DataDirectory\Arduino15$\r$\n"
        FileWrite $0 "  downloads: $DataDirectory\Library\Arduino15\staging$\r$\n"
        ReadEnvStr $1 "PortableApps.comDocuments"
        FileWrite $0 "  user: $1\Arduino$\r$\n"
        ReadEnvStr $1 "PAL:LanguageCustom"
        FileWrite $0 "locale: $1$\r$\n"
        FileClose $0
    ${EndIf}
!macroend