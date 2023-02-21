!addplugindir "${PACKAGE}\Other\Source\Plugins"

${SegmentFile}

${SegmentPrePrimary}
    ${registry::MoveKey} "HKEY_LOCAL_MACHINE\Software\Valve\Steam" "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKLM\Software\Valve\Steam" $0
    ${registry::MoveKey} "HKEY_LOCAL_MACHINE\Software\Valve\SteamService" "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKLM\Software\Valve\SteamService" $0

    SimpleSC::ExistsService "Steam Client Service"
    Pop $0
    ${If} $0 == 0
        ${registry::CopyKey} "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Steam Client Service" "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKLM\System\CurrentControlSet\Services\Steam Client Service" $0
    ${Else}
        SimpleSC::InstallService "Steam Client Service" "Steam Client Service" 16 3 '"$AppDirectory\Steam\bin\SteamService.exe" /RunAsService' "" "" ""
        SimpleSC::StartService "Steam Client Service" "" 30
    ${EndIf}
!macroend

${SegmentPostPrimary}
    ${registry::KeyExists} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKLM\System\CurrentControlSet\Services\Steam Client Service" $0
    ${IfNot} $0 == 0
        SimpleSC::StopService "Steam Client Service" 1 30
        SimpleSC::RemoveService "Steam Client Service"
    ${EndIf}
    ${registry::DeleteKey} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKLM\System\CurrentControlSet\Services\Steam Client Service" $0

    ${registry::SaveKey} "HKEY_LOCAL_MACHINE\Software\Valve\Steam" "$DataDirectory\settings\registry.reg" "/A=1" $0
    ${registry::SaveKey} "HKEY_LOCAL_MACHINE\Software\Valve\SteamService" "$DataDirectory\settings\registry.reg" "/A=1" $0
    ${registry::DeleteKey} "HKEY_LOCAL_MACHINE\Software\Valve\Steam" $0
    ${registry::DeleteKey} "HKEY_LOCAL_MACHINE\Software\Valve\SteamService" $0
    ${registry::MoveKey} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKLM\Software\Valve\Steam" "HKEY_LOCAL_MACHINE\Software\Valve\Steam" $0
    ${registry::MoveKey} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKLM\Software\Valve\SteamService" "HKEY_LOCAL_MACHINE\Software\Valve\SteamService" $0

    ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKLM\System\CurrentControlSet\Services" $0
    ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKLM\System\CurrentControlSet" $0
    ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKLM\System" $0
    ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKLM\Software\Valve" $0
    ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKLM\Software" $0
    ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys\HKLM" $0
    ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com\Keys" $0
    ${registry::DeleteKeyEmpty} "HKEY_CURRENT_USER\Software\PortableApps.com" $0
    ${registry::DeleteKeyEmpty} "HKEY_LOCAL_MACHINE\Software\Valve" $0
!macroend
