#Requires AutoHotkey v2.0
#SingleInstance Force

; Logitech Next button → PowerPoint next slide
PgDn::
{
    hwnd := WinExist("ahk_class PodiumParent ahk_exe POWERPNT.EXE")

    if hwnd
        ControlSend("{Right}", , hwnd)
}

; Logitech Previous button → PowerPoint previous slide
PgUp::
{
    hwnd := WinExist("ahk_class PodiumParent ahk_exe POWERPNT.EXE")

    if hwnd
        ControlSend("{Left}", , hwnd)
}
