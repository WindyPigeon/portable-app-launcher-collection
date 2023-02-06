${SegmentFile}

${SegmentPrePrimary}
    CreateDirectory "$DataDirectory\Library\Application Support\Google\AndroidStudio2022.1\options"

    ${IfNot} ${FileExists} "$DataDirectory\Library\Application Support\Google\AndroidStudio2022.1\options\jdk.table.xml"
        FileOpen $0 "$DataDirectory\Library\Application Support\Google\AndroidStudio2022.1\options\jdk.table.xml" w
        FileWrite $0 `\
                <application>$\r$\n  \
                  <component name="ProjectJdkTable">$\r$\n    \
                    <jdk version="2">$\r$\n      \
                      <name value="" />$\r$\n      \
                      <type value="Android SDK" />$\r$\n      \
                      <homePath value="" />$\r$\n      \
                      <roots />$\r$\n    \
                    </jdk>$\r$\n  \
                  </component>$\r$\n\
                </application>`
        FileClose $0

        CreateDirectory "$DataDirectory\Library\Android\sdk"
        ReadEnvStr $0 "PAL:DataDir:ForwardSlash"
        ${XMLWriteAttrib} "$DataDirectory\Library\Application Support\Google\AndroidStudio2022.1\options\jdk.table.xml" \
                '/application/component[@name="ProjectJdkTable"]/jdk[@version="2"][child::name[@value]][child::type[@value="Android SDK"]][child::roots]/homePath' \
                "value" \
                "$0/Library/Android/sdk"
    ${EndIf}

    ${IfNot} ${FileExists} "$DataDirectory\Library\Application Support\Google\AndroidStudio2022.1\options\ide.general.xml"
        FileOpen $0 "$DataDirectory\Library\Application Support\Google\AndroidStudio2022.1\options\ide.general.xml" w
        FileWrite $0 `\
                <application>  \
                  <component name="GeneralSettings">    \
                    <option name="defaultProjectDirectory" value="" />  \
                  </component>\
                </application>`
        FileClose $0

        ReadEnvStr $0 "PortableApps.comDocuments"
        ${XMLWriteAttrib} "$DataDirectory\Library\Application Support\Google\AndroidStudio2022.1\options\ide.general.xml" \
                '/application/component[@name="GeneralSettings"]/option[@name="defaultProjectDirectory"]' \
                "value" \
                "$0\AndroidStudioProjects"
    ${EndIf}
!macroend

${SegmentPostPrimary}
    Rename "$DataDirectory\Library\Caches\Google\AndroidStudio2022.1\log" \
            "$DataDirectory\Library\Logs\Google\AndroidStudio2022.1"
!macroend
