#Requires AutoHotkey v2.0
#SingleInstance Force

GetPowerPointWindow()
{
    hwnd := WinExist("ahk_class PodiumParent ahk_exe POWERPNT.EXE")

    if hwnd
        return hwnd

    hwnd := WinExist("ahk_class screenClass ahk_exe POWERPNT.EXE")

    if hwnd
        return hwnd

    return 0
}

SendToPowerPoint(key, keyName, virtualKey)
{
    hwnd := GetPowerPointWindow()

    if !hwnd
        return

    control := ""

    try control := ControlGetFocus(hwnd)

    if control
        ControlSend(control, key, hwnd)
    else {
        targetHwnd := hwnd
        controls := []

        try controls := WinGetControlsHwnd(hwnd)

        if controls.Length
            targetHwnd := controls[1]

        scanCode := GetKeySC(keyName)
        keyDownLParam := 1 | (scanCode << 16) | 0x01000000
        keyUpLParam := keyDownLParam | 0xC0000000

        SendMessage(0x100, virtualKey, keyDownLParam, , targetHwnd)
        SendMessage(0x101, virtualKey, keyUpLParam, , targetHwnd)
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
