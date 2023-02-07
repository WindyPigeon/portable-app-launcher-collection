${SegmentFile}

Var BINDIR
Var COMMAND

${SegmentPrePrimary}
    ${If} ${FileExists} "$EXEDIR\App\LilyPond\usr\bin\LilyPondPortable.exe"
    ${AndIf} ${FileExists} "$EXEDIR\App\LilyPond\usr\bin\lilypond-windows.exe"
        StrCpy $COMMAND "$EXEDIR\App\LilyPond\usr\bin\LilyPondPortable.exe"
        StrCpy $BINDIR "$EXEDIR\App\LilyPond\usr\bin"
    ${ElseIf} ${FileExists} "$EXEDIR\..\LilyPondPortable\App\LilyPond\usr\bin\LilyPondPortable.exe"
    ${AndIf} ${FileExists} "$EXEDIR\..\LilyPondPortable\App\LilyPond\usr\bin\lilypond-windows.exe"
        ReadEnvStr $0 "PAL:PortableAppsDir"
        StrCpy $COMMAND "$0\LilyPondPortable\App\LilyPond\usr\bin\LilyPondPortable.exe"
        StrCpy $BINDIR "$0\LilyPondPortable\App\LilyPond\usr\bin"
    ${ElseIf} ${FileExists} "$EXEDIR\LilyPondPortable.exe"
    ${AndIf} ${FileExists} "$EXEDIR\App\LilyPond\usr\bin\lilypond-windows.exe"
        StrCpy $COMMAND "$EXEDIR\LilyPondPortable.exe"
        StrCpy $BINDIR "$EXEDIR\App\LilyPond\usr\bin"
    ${ElseIf} ${FileExists} "$EXEDIR\..\LilyPondPortable\LilyPondPortable.exe"
    ${AndIf} ${FileExists} "$EXEDIR\..\LilyPondPortable\App\LilyPond\usr\bin\lilypond-windows.exe"
        ReadEnvStr $0 "PAL:PortableAppsDir"
        StrCpy $COMMAND "$0\LilyPondPortable\LilyPondPortable.exe"
        StrCpy $BINDIR "$0\LilyPondPortable\App\LilyPond\usr\bin"
    ${EndIf}

    ${IfNot} ${FileExists} "$DataDirectory\settings\org.frescobaldi.frescobaldi.reg"
        FileOpen $0 "$DataDirectory\settings\org.frescobaldi.frescobaldi.reg" w
        FileWrite $0 "Windows Registry Editor Version 5.00$\r$\n\
                $\r$\n"
        FileClose $0

        WriteINIStr "$DataDirectory\settings\org.frescobaldi.frescobaldi.reg" "HKEY_CURRENT_USER\Software\frescobaldi\frescobaldi\lilypondinfo" '"size"' "dword:00000001"

        ${WordReplace} "$COMMAND" "\" "/" "+" $0
        WriteINIStr "$DataDirectory\settings\org.frescobaldi.frescobaldi.reg" "HKEY_CURRENT_USER\Software\frescobaldi\frescobaldi\lilypondinfo\1" '"command"' '"$0"'

        ${GetParent} "$COMMAND" $0
        StrLen $1 "$0"
        StrCpy $2 "$BINDIR" $1
        ${If} $COMMAND == "$1"
            ${WordReplace} "$BINDIR" "$0" "" "+1" $0
            ${WordReplace} "$0" "\" "/" "+" $0
            WriteINIStr "$DataDirectory\settings\org.frescobaldi.frescobaldi.reg" "HKEY_CURRENT_USER\Software\frescobaldi\frescobaldi\lilypondinfo\1" '"abc2ly"' '"$0/abc2ly"'
            WriteINIStr "$DataDirectory\settings\org.frescobaldi.frescobaldi.reg" "HKEY_CURRENT_USER\Software\frescobaldi\frescobaldi\lilypondinfo\1" '"convert-ly"' '"$0/convert-ly"'
            WriteINIStr "$DataDirectory\settings\org.frescobaldi.frescobaldi.reg" "HKEY_CURRENT_USER\Software\frescobaldi\frescobaldi\lilypondinfo\1" '"lilypond-book"' '"$0/lilypond-book"'
            WriteINIStr "$DataDirectory\settings\org.frescobaldi.frescobaldi.reg" "HKEY_CURRENT_USER\Software\frescobaldi\frescobaldi\lilypondinfo\1" '"midi2ly"' '"$0/midi2ly"'
            WriteINIStr "$DataDirectory\settings\org.frescobaldi.frescobaldi.reg" "HKEY_CURRENT_USER\Software\frescobaldi\frescobaldi\lilypondinfo\1" '"musicxml2ly"' '"$0/musicxml2ly"'
        ${EndIf}
    ${EndIf}

    ReadEnvStr $0 "PATH"
    ${SetEnvironmentVariablesPath} "PATH" "$0;$BINDIR"
!macroend
