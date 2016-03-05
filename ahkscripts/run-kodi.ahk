run, "C:\Program Files (x86)\Kodi\Kodi.exe"
WinWait ahk_class Kodi
WS_EX_TOOLWINDOW := 0x00000080
WinSet, ExStyle, +%WS_EX_TOOLWINDOW%, ahk_class Kodi
WinMaximize, ahk_class Kodi
