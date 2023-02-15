!addplugindir "${PACKAGE}\Other\Source\Plugins"

${SegmentFile}

${SegmentInit}
    ReadEnvStr $0 "PortableApps.comLanguageCode"
    ${If} $0 == ""
    ${AndIf} ${FileExists} "$DataDirectory\Library\Application Support\Code\User\locale.json"
        nsJSON::Set /file "$DataDirectory\Library\Application Support\Code\User\locale.json"
        ClearErrors
        nsJSON::Get "locale" /end
        ${IfNot} ${Errors}
            Pop $0
            ${SetEnvironmentVariable} "PortableApps.comLanguageCode" "-"
            ${SetEnvironmentVariable} "PAL:LanguageCustom" "$0"
        ${EndIf}
    ${EndIf}
!macroend

${SegmentPrePrimary}
    ReadEnvStr $0 "PAL:LanguageCustom"

    ${Switch} $0
        ${Case} "zh-hans"
            StrCpy $0 "zh-cn"
            ${Break}
        ${Case} "zh-hant"
            StrCpy $0 "zh-tw"
            ${Break}
    ${EndSwitch}

    ${If} ${FileExists} "$DataDirectory\Library\Application Support\Code\User\locale.json"
        nsJSON::Set /file "$DataDirectory\Library\Application Support\Code\User\locale.json"
    ${Else}
        nsJSON::Set /value {}
    ${EndIf}

    ReadEnvStr $0 "PAL:LanguageCustom"
    nsJSON::Set "locale" /value '"$0"'
    nsJSON::Serialize /format /file "$DataDirectory\Library\Application Support\Code\User\locale.json"

    ${If} ${FileExists} "$AppDirectory\Microsoft VS Code\resources\app\product.json"
        nsJSON::Set /file "$AppDirectory\Microsoft VS Code\resources\app\product.json"
        nsJSON::Delete `target` /end
        nsJSON::Serialize /format /file "$AppDirectory\Microsoft VS Code\resources\app\product.json"
    ${EndIf}

    CreateDirectory "$AppDirectory\Microsoft VS Code\data"
!macroend
