#Requires AutoHotkey v2.0

; MATLAB Hierarchical Code Formatting System
; ===========================================
; Organized by hierarchy levels for clear code structure

#HotIf WinActive("ahk_exe MATLAB.exe") or WinActive("ahk_class SunAwtFrame") or (InStr(WinGetTitle("A"), "MATLAB") > 0)


; =====================================
; LEVEL 1: MAIN TOPICS (Highest Level)
; =====================================

; Main topic box - creates centered box (Alt+Shift+=)
!+=::
{
    SendInput("{Home}+{End}^c")
    Sleep 50
    currentLine := A_Clipboard
    
    if (SubStr(currentLine, 1, 1) = "%") {
        topicName := Trim(SubStr(currentLine, 2))
    } else {
        topicName := Trim(currentLine)
    }
    
    if (topicName != "") {
        textLength := StrLen(topicName)
        totalWidth := textLength + 6
        
        if (totalWidth < 50) {
            totalWidth := 50
        }
        
        borderLine := ""
        Loop totalWidth {
            borderLine .= "%"
        }
        
        paddingTotal := totalWidth - textLength - 2
        paddingLeft := Floor(paddingTotal / 2)
        paddingRight := paddingTotal - paddingLeft
        
        leftSpaces := ""
        rightSpaces := ""
        Loop paddingLeft {
            leftSpaces .= " "
        }
        Loop paddingRight {
            rightSpaces .= " "
        }
        
        SendInput("{Home}+{End}")
        middleLine := "%" . leftSpaces . topicName . rightSpaces . "%"
        SendText(borderLine . "`n" . middleLine . "`n" . borderLine)
    }
    return
}


; =====================================
; LEVEL 2: MAJOR SECTIONS
; =====================================

; Major section with double equals
::sec::
{
    SendText("%% ==================  ==================")
    SendInput("{Left 19}")
    return
}


; =====================================
; LEVEL 3: SUBSECTIONS
; =====================================

; Subsection with equals line below (Alt+=)
!=::
{
    SendInput("{Home}+{End}^c")
    Sleep 50
    currentLine := A_Clipboard
    
    if (SubStr(currentLine, 1, 1) = "%") {
        textPart := SubStr(currentLine, 3)
        
        equalsLine := ""
        Loop StrLen(textPart) {
            equalsLine .= "="
        }
        
        SendInput("{End}{Enter}% " . equalsLine)
    }
    return
}


; Timed subsection (e.g., ::tsub:: for "% === Subsection [2025-10-27 14:30] ===")
::tsub::
{
    timestamp := FormatTime(, "yyyy-MM-dd HH:mm")
    SendText("% === [") 
    SendInput(timestamp . "] ===")
    SendInput("{Left 7}")  ; Position for name
    return
}


; =====================================
; LEVEL 4: MINOR TOPICS
; =====================================

; Minor topic with dashes
::top::
{
    SendText("%---  ---")
    SendInput("{Left 4}")
    return
}


; =====================================
; LEVEL 5: SEPARATORS
; =====================================

; Segment separator with spacing
::seg::
{
    SendText("`n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%`n`n")
    return
}


; =====================================
; LEVEL 6: NOTES AND ANNOTATIONS
; =====================================

; NOTE comment
::note::
{
    SendText("% NOTE: ")
    return
}

; TODO comment
::todo::
{
    SendText("% TODO: ")
    return
}

; WARNING comment
::warn::
{
    SendText("% WARNING: ")
    return
}

; IMPORTANT comment
::imp::
{
    SendText("% IMPORTANT: ")
    return
}

; FIX comment
::fix::
{
    SendText("% FIX: ")
    return
}


; =====================================
; LEVEL 7: INLINE ELEMENTS
; =====================================

; Unit notation
::unt::
{
    SendText("% []")
    SendInput("{Left 1}")
    return
}


; =====================================
; SPECIAL FORMATTING
; =====================================

; File header with metadata
::intro::
{
    today := FormatTime(, "dd-MM-yyyy")
    dayName := FormatTime(, "dddd")
    
    headerText := "% Author: Dev Rajyaguru`n"
    headerText .= "% Date: " . today . " (" . dayName . ")`n`n"
    headerText .= "% Title: `n"
    headerText .= "% Description: `n"
    headerText .= "% Version: 1.0`n`n"  ; Added version for better tracking as code evolves
    headerText .= "% Dependencies: (e.g., MATLAB toolboxes used)`n`n"
    headerText .= "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%`n"
    
    SendText(headerText)
    SendInput("{Up 5}{End}")  ; Positions cursor at the end of the Title line for easy editing
    return
}


; Multiline comment block
::mulcom::
{
    SendText("%{`n`n%}")
    SendInput("{Up 1}")
    return
}

; Function header
::func::
{
    SendText("% Function: `n% Inputs: `n% Outputs: `n% Description: ")
    SendInput("{Up 3}{End}")
    return
}


; =====================================
; TEMPLATES
; =====================================

; Figure plotting template
::figtemp::
{
    figureCode := "
(
%--- Figure Setup ---
figure('Name', 'Figure Title', 'NumberTitle', 'off');
plot(x, y, 'LineWidth', 2, 'Color', 'b');
xlabel('X Label');
ylabel('Y Label');
title('Plot Title');
legend('Data');
grid minor;
)"
    SendText(figureCode)
    SendInput("{Up 6}{End}{Left 18}")
    return
}


; =====================================
; UTILITY SHORTCUTS
; =====================================

; Delete entire line (Shift+Backspace)
<+Backspace::
{
    SendInput("{Home}")
    SendInput("+{End}")
    SendInput("{Backspace}")
}

; Delete entire word (Ctrl+Backspace)
^Backspace::
{
    SendInput("^{Left}")        
    SendInput("+^{Right}")
    SendInput("{Delete}")
}


#HotIf