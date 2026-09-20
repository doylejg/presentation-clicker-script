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

GetPowerPointInputTarget(hwnd)
{
    pid := 0
    threadId := DllCall("GetWindowThreadProcessId", "Ptr", hwnd, "UInt*", pid, "UInt")
    guiThreadInfo := Buffer(8 + (A_PtrSize * 6) + 16, 0)
    NumPut("UInt", guiThreadInfo.Size, guiThreadInfo, 0)

    if threadId && DllCall("GetGUIThreadInfo", "UInt", threadId, "Ptr", guiThreadInfo.Ptr) {
        focusedHwnd := NumGet(guiThreadInfo, 8 + A_PtrSize, "Ptr")

        if focusedHwnd
            return focusedHwnd
    }

    return hwnd
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
    targetHwnd := GetPowerPointInputTarget(hwnd)

    PostMessage(0x100, virtualKey, keyDownLParam, , targetHwnd)
    Sleep(10)
    PostMessage(0x101, virtualKey, keyUpLParam, , targetHwnd)
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
