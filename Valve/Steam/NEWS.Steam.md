# Steam NEWS

- The Steam Client Service is required to run Steam.
  - Service properties:
    - Service name: `Steam Client Service`
    - Display name: `Steam Client Service`
    - Service type: SERVICE_WIN32_OWN_PROCESS (16)
    - Startup type: SERVICE_DEMAND_START (3)
    - Binary path: `"<SteamAppDirectory>\bin\SteamService.exe" /RunAsService`

- The list of music library directories is stored in the *config.vdf* file under the `InstallConfigStore.Music.LocalLibrary.Directories` key. All directory paths are encoded in an unknown format.

- Generate registry keys at runtime.
  - Registry keys:
    - HKCU
        - `HKEY_CURRENT_USER\Software\Valve\Steam`
    - HKLM
        - `HKEY_LOCAL_MACHINE\Software\Valve\Steam`
        - `HKEY_LOCAL_MACHINE\Software\Valve\SteamService`
  - For MacOS and Linux, all registry entries are kept in the *registry.vdf* file in the `~/Library/Application Support/Steam` directory (for MacOS) and the `$HOME/.steam` directory (for Linux).