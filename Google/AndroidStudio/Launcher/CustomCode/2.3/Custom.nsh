${SegmentFile}

${SegmentPrePrimary}
    CreateDirectory "$DataDirectory\Library\Preferences\AndroidStudio2.3\options"

    ${IfNot} ${FileExists} "$DataDirectory\Library\Preferences\AndroidStudio2.3\options\jdk.table.xml"
        FileOpen $0 "$DataDirectory\Library\Preferences\AndroidStudio2.3\options\jdk.table.xml" w
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
        ${XMLWriteAttrib} "$DataDirectory\Library\Preferences\AndroidStudio2.3\options\jdk.table.xml" \
                '/application/component[@name="ProjectJdkTable"]/jdk[@version="2"][child::name[@value]][child::type[@value="Android SDK"]][child::roots]/homePath' \
                "value" \
                "$0/Library/Android/sdk"
    ${EndIf}

    ${IfNot} ${FileExists} "$DataDirectory\Library\Preferences\AndroidStudio2.3\options\recentProjects.xml"
        FileOpen $0 "$DataDirectory\Library\Preferences\AndroidStudio2.3\options\recentProjects.xml" w
        FileWrite $0 `\
                <application>  \
                  <component name="RecentProjectsManager">    \
                    <option name="lastProjectLocation" value="" />  \
                  </component>\
                </application>`
        FileClose $0

        ReadEnvStr $0 "PortableApps.comDocuments"
        ${XMLWriteAttrib} "$DataDirectory\Library\Preferences\AndroidStudio2.3\options\recentProjects.xml" \
                '/application/component[@name="RecentProjectsManager"]/option[@name="lastProjectLocation"]' \
                "value" \
                "$0\AndroidStudioProjects"
    ${EndIf}

    ${registry::MoveValue} "HKEY_CURRENT_USER\Software\JavaSoft\Prefs" \
            "/Jet/Brains./User/Id/On/Machine" \
            "HKEY_CURRENT_USER\Software\PortableApps.com\Values" \
            "/Jet/Brains./User/Id/On/Machine" \
            $0
!macroend

${SegmentPostPrimary}
    ${registry::SaveKey} "HKEY_CURRENT_USER\Software\JavaSoft\Prefs" \
            "$DataDirectory\settings\com.java.util.prefs.reg" \
            '/A=1 /N="/Jet/Brains./User/Id/On/Machine" /G=0'  \
            $0

    ${registry::DeleteValue} "HKEY_CURRENT_USER\Software\JavaSoft\Prefs" \
            "/Jet/Brains./User/Id/On/Machine" \
            $0

    ${registry::MoveValue} "HKEY_CURRENT_USER\Software\PortableApps.com\Values" \
            "/Jet/Brains./User/Id/On/Machine" \
            "HKEY_CURRENT_USER\Software\JavaSoft\Prefs" \
            "/Jet/Brains./User/Id/On/Machine" \
            $0

    ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Values" $0
    ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com" $0

    ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\JavaSoft\Prefs" $0
    ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\JavaSoft" $0

    Rename "$DataDirectory\Library\Caches\AndroidStudio2.3\log" \
            "$DataDirectory\Library\Logs\AndroidStudio2.3"
!macroend
