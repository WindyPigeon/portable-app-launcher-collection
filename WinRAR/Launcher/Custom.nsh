${SegmentFile}

${SegmentPre}
    ${IfNot} ${FileExists} "$DataDirectory\settings\WinRAR.reg"
        FileOpen $0 "$DataDirectory\settings\WinRAR.reg" w
        FileWrite $0 "Windows Registry Editor Version 5.00$\r$\n\
                $\r$\n"
        FileClose $0
        
        ReadEnvStr $0 "USERPROFILE:DoubleBackslash"
        WriteINIStr "$DataDirectory\settings\WinRAR.reg" \
                'HKEY_CURRENT_USER\Software\WinRAR\General' \
                '"LastFolder"' \
                '"$0\\Desktop"'
    ${EndIf}
!macroend
