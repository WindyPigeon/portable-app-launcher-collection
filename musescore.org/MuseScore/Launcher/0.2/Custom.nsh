${SegmentFile}

${SegmentPrePrimary}
    System::Call 'gdi32::AddFontResource(t"$AppDirectory\Fonts\emmentaler.ttf")i .r0'
!macroend

${SegmentPostPrimary}
    System::Call 'gdi32::RemoveFontResource(t"$AppDirectory\Fonts\emmentaler.ttf")i .r0'
!macroend
