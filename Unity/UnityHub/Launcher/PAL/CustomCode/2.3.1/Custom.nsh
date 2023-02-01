!addplugindir `${PACKAGE}\Other\Source\Plugins`

${SegmentFile}

${SegmentInit}
    ReadEnvStr $0 PortableApps.comLanguageCode
    ${If} $0 == ""
    ${AndIf} ${FileExists} "$DataDirectory\Library\Application Support\UnityHub\languageConfig.json"
        nsJSON::Set /file "$DataDirectory\Library\Application Support\UnityHub\languageConfig.json"
        ClearErrors
        nsJSON::Get language /end
        ${IfNot} ${Errors}
            Pop $0
            ${SetEnvironmentVariable} PortableApps.comLanguageCode -
            ${SetEnvironmentVariable} PAL:LanguageCustom $0
        ${EndIf}
    ${EndIf}
!macroend

${SegmentPrePrimary}
    ${IfNot} ${FileExists} "$DataDirectory\Library\Application Support\UnityHub\secondaryInstallPath.json"
        CreateDirectory "$DataDirectory\Library\Application Support\UnityHub"
        FileOpen    $0  "$DataDirectory\Library\Application Support\UnityHub\secondaryInstallPath.json" w
        ReadEnvStr  $1  PAL:AppDir:DoubleBackslash
        FileWrite   $0  '"$1\\Unity\\Hub\\Editor"'
        FileClose   $0
    ${EndIf}

    ${IfNot} ${FileExists} "$DataDirectory\Library\Application Support\UnityHub\projectDir.json"
        CreateDirectory "$DataDirectory\Library\Application Support\UnityHub"
        nsJSON::Set /file "$DataDirectory\Library\Application Support\UnityHub\projectDir.json"
        ReadEnvStr $0 PortableApps.comDocuments:DoubleBackslash
        nsJSON::Set directoryPath /value '"$0"'
        nsJSON::Serialize /format /file "$DataDirectory\Library\Application Support\UnityHub\projectDir.json"
    ${EndIf}

    ReadEnvStr $0 PAL:LanguageCustom
    CreateDirectory "$DataDirectory\Library\Application Support\UnityHub"
    nsJSON::Set /file "$DataDirectory\Library\Application Support\UnityHub\languageConfig.json"
    nsJSON::Set language /value '"$0"'
    nsJSON::Serialize /format /file "$DataDirectory\Library\Application Support\UnityHub\languageConfig.json"
!macroend

${SegmentPostPrimary}
    Rename  "$DataDirectory\Library\Application Support\UnityHub\logs"  \
            "$DataDirectory\Library\Logs\Unity Hub"

    RMDir   "$DataDirectory\Library\Application Support\UnityHub\Plugins"

    ReadEnvStr $0 APPDATA
    RMDir   "$0\UnityHub\Plugins"
    RMDir   "$0\UnityHub"
    RMDir   "$0"
!macroend
