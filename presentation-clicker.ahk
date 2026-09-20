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

SendToPowerPoint(key, keyName, virtualKey)
{
    window := GetPowerPointWindow()

    if !window
        return

    control := ""

    try control := ControlGetFocus(window)

    if control
        ControlSend(control, key, window)
    else {
        scanCode := GetKeySC(keyName)
        keyDownLParam := 1 | (scanCode << 16) | 0x01000000
        keyUpLParam := keyDownLParam | 0xC0000000

        PostMessage(0x100, virtualKey, keyDownLParam, , window)
        PostMessage(0x101, virtualKey, keyUpLParam, , window)
    }
}

; Logitech Next button → PowerPoint next slide
PgDn::
{
    SendToPowerPoint("{Right}", "Right", 0x27)
}

; Logitech Previous button → PowerPoint previous slide
PgUp::
{
    SendToPowerPoint("{Left}", "Left", 0x25)
}
