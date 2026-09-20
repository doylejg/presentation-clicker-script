# presentation-clicker-script

AutoHotkey v2 script for using Logitech presenter buttons to control PowerPoint slides.

## Files

- `presentation-clicker.ahk` - maps `PgDn` to next slide and `PgUp` to previous slide in Microsoft PowerPoint

## Requirements

- Windows
- Microsoft PowerPoint
- [AutoHotkey v2](https://www.autohotkey.com/)

## Setup

1. Download AutoHotkey v2 from the [official download page](https://www.autohotkey.com/).
2. Run the installer.
3. Choose the v2 installation option if prompted.
4. Clone or download this repository.

## Run the script

1. Locate `presentation-clicker.ahk` in the folder you downloaded or cloned.
2. Double-click the file to run it with AutoHotkey.
3. Start your PowerPoint slideshow or presenter view.
4. Use the presenter buttons that send `PgDn` and `PgUp` to move forward and backward through slides.

## Notes

- The script only sends slide navigation keys when PowerPoint is running.
- If your presenter sends different key codes, update the hotkeys in `presentation-clicker.ahk`.