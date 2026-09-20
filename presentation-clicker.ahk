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

    if control {
        try {
            ControlSend(control, key, hwnd)
            return
        }
    }

    scanCode := GetKeySC(keyName)
    isExtendedKey := scanCode > 0xFF
    scanCode := scanCode & 0xFF
    keyDownLParam := 1 | (scanCode << 16)

    if isExtendedKey
        keyDownLParam := keyDownLParam | 0x01000000

    keyUpLParam := keyDownLParam | 0xC0000000

    PostMessage(0x100, virtualKey, keyDownLParam, , hwnd)
    Sleep(10)
    PostMessage(0x101, virtualKey, keyUpLParam, , hwnd)
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
