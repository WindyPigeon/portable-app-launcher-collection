
${SegmentFile}

${SegmentPrePrimary}
    System::Call 'gdi32::AddFontResource(t"$AppDirectory\Denemo\share\fonts\truetype\denemo\feta.ttf")i .r2'
    System::Call 'gdi32::AddFontResource(t"$AppDirectory\Denemo\share\fonts\truetype\denemo\Denemo.ttf")i .r2'
    System::Call 'gdi32::AddFontResource(t"$AppDirectory\Denemo\share\fonts\truetype\denemo\emmentaler.ttf")i .r2'
!macroend

${SegmentPostPrimary}
    System::Call 'gdi32::RemoveFontResource(t"$AppDirectory\Denemo\share\fonts\truetype\denemo\feta.ttf")i .r2'
    System::Call 'gdi32::RemoveFontResource(t"$AppDirectory\Denemo\share\fonts\truetype\denemo\Denemo.ttf")i .r2'
    System::Call 'gdi32::RemoveFontResource(t"$AppDirectory\Denemo\share\fonts\truetype\denemo\emmentaler.ttf")i .r2'
!macroend
