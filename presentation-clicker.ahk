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

SendToPowerPoint(key)
{
    window := GetPowerPointWindow()

    if !window
        return

    WinActivate(window)

    if WinWaitActive(window, , 1)
        Send(key)
}

; Logitech Next button → PowerPoint next slide
PgDn::
{
    SendToPowerPoint("{Right}")
}

; Logitech Previous button → PowerPoint previous slide
PgUp::
{
    SendToPowerPoint("{Left}")
}
