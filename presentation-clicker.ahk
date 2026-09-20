#Requires AutoHotkey v2.0
#SingleInstance Force

GetPowerPointWindow()
{
    hwnd := WinExist("ahk_class PodiumParent ahk_exe POWERPNT.EXE")

    if hwnd
        return "ahk_id " hwnd

    hwnd := WinExist("ahk_class screenClass ahk_exe POWERPNT.EXE")

    if hwnd
        return "ahk_id " hwnd

    return ""
}

SendToPowerPoint(key, virtualKey)
{
    window := GetPowerPointWindow()

    if !window
        return

    control := ""

    try control := ControlGetFocus(window)

    if control
        ControlSend(key, control, window)
    else {
        PostMessage(0x100, virtualKey, 1, , window)
        PostMessage(0x101, virtualKey, 0xC0000001, , window)
    }
}

; Logitech Next button → PowerPoint next slide
PgDn::
{
    SendToPowerPoint("{Right}", 0x27)
}

; Logitech Previous button → PowerPoint previous slide
PgUp::
{
    SendToPowerPoint("{Left}", 0x25)
}
