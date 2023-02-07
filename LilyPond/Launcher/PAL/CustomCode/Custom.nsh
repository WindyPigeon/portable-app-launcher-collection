${SegmentFile}

${SegmentPreExec}
    System::Call "kernel32::GetCurrentDirectory(i ${NSIS_MAX_STRLEN}, t .r0)"
    SetOutPath $0
!macroend
