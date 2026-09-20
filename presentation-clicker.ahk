#Requires AutoHotkey v2.0
#SingleInstance Force

GetPowerPointWindow()
{
    hwnd := WinExist("ahk_class PodiumParent ahk_exe POWERPNT.EXE")

    if hwnd
        return hwnd

    return WinExist("ahk_class screenClass ahk_exe POWERPNT.EXE")
}

; Logitech Next button → PowerPoint next slide
PgDn::
{
    hwnd := GetPowerPointWindow()

    if hwnd
        ControlSend("{Right}", , hwnd)
}

; Logitech Previous button → PowerPoint previous slide
PgUp::
{
    hwnd := GetPowerPointWindow()

    if hwnd
        ControlSend("{Left}", , hwnd)
}
