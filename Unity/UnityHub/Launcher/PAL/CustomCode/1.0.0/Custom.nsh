!addplugindir `${PACKAGE}\Other\Source\Plugins`

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
!macroend

${SegmentPostPrimary}
    Rename  "$DataDirectory\Library\Application Support\UnityHub\logs"  \
            "$DataDirectory\Library\Logs\Unity Hub"
!macroend
