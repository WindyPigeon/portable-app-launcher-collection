${SegmentFile}

${SegmentPrePrimary}
    ${IfNot} ${FileExists} "$DataDirectory\Library\Application Support\tetraface\Metasequoia4\Metaseq.setting.xml"
        CreateDirectory "$DataDirectory\Library\Application Support\tetraface\Metasequoia4"
        FileOpen $0 "$DataDirectory\Library\Application Support\tetraface\Metasequoia4\Metaseq.setting.xml" w
        FileWrite $0 "<?xml version='1.0' encoding='UTF-8'?>$\r$\n\
                <MetasequoiaSetting>$\r$\n    \
                    <MainSetting>$\r$\n        \
                        <Interface>$\r$\n            \
                            <Language></Language>$\r$\n        \
                        </Interface>$\r$\n    \
                        <System>$\r$\n            \
                            <BackupDir></BackupDir>$\r$\n        \
                        </System>$\r$\n    \
                    </MainSetting>$\r$\n\
                </MetasequoiaSetting>"
        FileClose $0

        ${XMLWriteText} "$DataDirectory\Library\Application Support\tetraface\Metasequoia4\Metaseq.setting.xml" \
                "/MetasequoiaSetting/MainSetting/System/BackupDir" \
			    "$DataDirectory\Library\Application Support\tetraface\Metasequoia4\backup\"
    ${EndIf}
!macroend
