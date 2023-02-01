${SegmentFile}

${SegmentPrePrimary}
    Delete "$DataDirectory\Library\Logs\Unity\Editor-prev.log"
    Rename "$DataDirectory\Library\Logs\Unity\Editor.log" "$DataDirectory\Library\Logs\Unity\Editor-prev.log"
!macroend
