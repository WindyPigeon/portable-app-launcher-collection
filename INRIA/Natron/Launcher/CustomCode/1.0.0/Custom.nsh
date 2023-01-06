${SegmentFile}

${SegmentPrePrimary}
    ${IfNot} ${FileExists}  $DataDirectory\settings\com.inria.Natron.reg
        FileOpen    $0  $DataDirectory\settings\com.inria.Natron.reg   w
        FileWrite   $0  "Windows Registry Editor Version 5.00$\r$\n\
                $\r$\n"
        FileClose   $0

        CreateDirectory $DataDirectory\Library\Caches\Natron
        ReadEnvStr  $0 PAL:DataDir:ForwardSlash
        WriteINIStr $DataDirectory\settings\com.inria.Natron.reg   \
                'HKEY_CURRENT_USER\Software\INRIA\Natron'   \
                '"diskCachePath"'   \
                '"$0/Library/Caches/Natron"'

        ReadEnvStr  $0 PortableApps.comDocuments:ForwardSlash
        WriteINIStr $DataDirectory\settings\com.inria.Natron.reg   \
                'HKEY_CURRENT_USER\Software\INRIA\Natron'   \
                '"LastSaveProjectDialogPath"'   \
                '"$0/"'
    ${EndIf}
!macroend