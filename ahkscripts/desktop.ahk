SetTitleMatchMode, RegEx

LWin:: return
RWin:: return

Ctrl & g::Send {Escape}

RWin & y::Send {AppsKey}

RWin & h::Send {RWin down}{Tab}{RWin up}

RWin & j::AltTab
RWin & k::ShiftAltTab

RWin & Up::Send {RWin down}{LCtrl down}{Left}{RWin up}{LCtrl up}
RWin & Down::Send {RWin down}{LCtrl down}{Right}{RWin up}{LCtrl up}

RWin & n::WinClose, A
;RWin & n::Send {LAlt down}{F4}{LAlt up}
;RWin & n::
;  Send {LAlt down}{Space}{LAlt up}
;  Sleep 10
;  Send c
;  return

; RWin & m:: WinMaximize, A
RWin & m::
  WinGet MX, MinMax, A
  if (MX = 1) {
    WinRestore, A
  }
  else {
    WinMaximize, A
  }
  return

RWin & u::Send {RWin down}{Left}{RWin up}
RWin & i::Send {RWin down}{Right}{RWin up}
RWin & 0::Send {RWin down}{Ctrl down}{Alt down}0{RWin up}{Ctrl up}{Alt up}
RWin & 9::Send {RWin down}{Ctrl down}{Alt down}9{RWin up}{Ctrl up}{Alt up}
RWin & 8::Send {RWin down}{Ctrl down}{Alt down}8{RWin up}{Ctrl up}{Alt up}
RWin & 7::Send {RWin down}{Ctrl down}{Alt down}7{RWin up}{Ctrl up}{Alt up}

;RWin & u::
;    SysGet, WA, MonitorWorkArea
;    ;MsgBox, Left: %WALeft% -- Top: %WATop% -- Right: %WARight% -- Bottom %WABottom%.
;    WAWidth := WARight - WALeft
;    WAHeight := WABottom - WATop
;    ;MsgBox, Left: %WALeft% -- Top: %WATop% -- Right: %WARight% -- Bottom %WABottom% -- Width: %WAWidth% -- Height: %WAHeight%
;    WinMove, A,, 0, WATop, WAWidth/2, WAHeight
;    return

#0::Send {Media_Play_Pause}
#!0::Send {Media_Next}
RWin & PgUp::Send {Volume_Up}
RWin & PgDn::Send {Volume_Down}

;RWin & h::Send {RWin down}{Tab}{RWin up}

; http://superuser.com/questions/429930/using-capslock-to-switch-the-keyboard-language-layout#431302
;SetCapsLockState, AlwaysOff
;+CapsLock::CapsLock

Shift & Escape::Send, {LAlt down}{LShift down}{LShift up}{LAlt up}

Shift & CapsLock::Send, {LAlt down}{LShift down}{LShift up}{LAlt up}
return

CapsLock::Escape
Escape::CapsLock

;RWin & -::
;  SwitchToWindowAndSendKey("- Google Play Music", "{Space down}{Space up")
;  return
;RWin & ]::
;  SwitchToWindowAndSendKey("- Google Play Music", "{Right down}{Right up")
;  return
;RWin & [::
;  SwitchToWindowAndSendKey("- Google Play Music", "{Left down}{Left up}")
;  return

;RWin & -::
;  SwitchToWindowAndSendKey("ahk_exe Google Play Music Desktop Player.exe", "{Space down}{Space up}")
;  return
;RWin & ]::
;  SwitchToWindowAndSendKey("ahk_exe Google Play Music Desktop Player.exe", "{Right down}{Right up}")
;  return
;RWin & [::
;  SwitchToWindowAndSendKey("ahk_exe Google Play Music Desktop Player.exe", "{Left down}{Left up}")
;  return

RWin & l::DllCall("LockWorkStation")

;RWin & o::
;  Send, {RWin down}6{RWin up}
;  WinWait, ahk_exe FancyZonesEditor.exe
;  if ErrorLevel
;  {
;    MsgBox, WinWait timed out.
;    return
;  }
;  else {
;   WinActivate ahk_exe FancyZonesEditor.exe, , "FancyZones Layout"
;   Send, {Tab}{Right}{Right}{Right}{Right}
;   MsgBox, "Hooray"
;  }


#IfWinActive ahk_exe MTGA.exe
XButton1::Send {Space down}{Space up}
XButton2::Send {Ctrl down}{Shift down}{Shift up}{Ctrl up}
#IfWinActive

#IfWinActive ahk_exe Telegram.exe
RWin & n::Send {LAlt down}{F4}{LAlt up}
;RWin & ,::
;  Send {LAlt down}{Space}{LAlt up}
;  Sleep 10
;  Send n
;  return
#IfWinActive

; Graviteam Tactics: Mius-Front
#IfWinActive, ahk_class i_Window
XButton1::MButton
#IfWinActive

#IfWinActive, ahk_exe FTLGame.exe
XButton1::Send {Backspace}
#IfWinActive

#IfWinActive, ahk_exe CivilizationVI.exe
XButton1::Send {Return}
XButton2::Send {Escape}
#IfWinActive

#IfWinActive, ahk_exe ST Earth.exe
XButton1::Send {Space}
XButton2::Send {Tab}
#IfWinActive

#IfWinActive, ahk_exe stellaris.exe
XButton1::Send {Space}
XButton2::Send M
#IfWinActive

#IfWinActive, ahk_exe imperator.exe
XButton1::Send {Space}
XButton2::Send M
#IfWinActive

#IfWinActive, ahk_exe hoi4.exe
XButton1::Send {Space}
XButton2::Send {F1}
#IfWinActive

#IfWinActive, ahk_exe CK2game.exe
XButton1::Send {Space}
XButton2::Send q
#IfWinActive

#IfWinActive, ahk_exe ck3.exe
XButton1::Send {Space}
XButton2::Send q
#IfWinActive

#IfWinActive, ahk_exe eu4.exe
XButton1::Send {Space}
XButton2::Send q
#IfWinActive

#IfWinActive, ahk_exe CivilizationVI_DX12.exe
XButton1::Send {Escape}
XButton2::Send {Enter}
#IfWinActive

#IfWinActive ahk_exe Skype.exe
RWin & n::Send {LAlt down}{F4}{LAlt up}
#IfWinActive

#IfWinActive ahk_exe mowas_2.exe
XButton1::Send {Pause}
#IfWinActive

#IfWinActive, ahk_exe Rome2.exe
XButton1::Send =
#IfWinActive

#IfWinActive, ahk_class VirtualConsoleClass
RWin & n::WinClose, A
;Ctrl & Left::Send {LAlt down}b{LAlt up}
;Ctrl & Right::Send {LAlt down}f{LAlt up}
;Ctrl & Backspace::Send {LAlt down}{Backspace}{LAlt up}
;Ctrl & Delete::Send {LAlt down}d{LAlt up}
;Shift & PgUp::Send {LCtrl down}{PgUp down}{PgUp up}{LCtrl up}
;Shift & PgDn::Send {LCtrl down}{PgDn down}{PgDn up}{LCtrl up}
;;Ctrl & PgUp::Send {LCtrl down}{Tab down}{Tab up}{LCtrl up}
;;Ctrl & PgDn::Send {LCtrl down}{LShift down}{Tab down}{Tab up}{LShift up}{LCtrl up}
#IfWinActive

;#IfWinActive, ^aleksei@
;Ctrl & Left::Send {LAlt down}b{LAlt up}
;#IfWinActive

#IfWinActive ahk_exe ahk_exe Evernote.exe
RWin & n::Send {LAlt down}{F4}{LAlt up}
#IfWinActive

SwitchToWindowAndSendKey(tWindowTitle, tKey)
{
  CurrentWinId := WinExist("A")
  WinGet, isTargetWindowMinimized, MinMax, %tWindowTitle%
  WinActivate %tWindowTitle%
  Send, %tKey%
  WinActivate, ahk_id %CurrentWinId%
  if isTargetWindowMinimized=-1
  {
    WinMinimize, %tWindowTitle%
  }
  return
}



RWin & `;::Run "C:\Program Files\Mozilla Firefox\firefox.exe"
RWin & '::Run "C:\Users\aleks\AppData\Local\Microsoft\WindowsApps\wt.exe"
; RWin & '::Run "C:\Program Files\ConEmu\ConEmu64.exe"
RWin & .::Run "C:\Users\aleks\AppData\Roaming\Telegram Desktop\Telegram.exe"
#^0::Run "C:\Users\aleks\AppData\Local\Programs\youtube-music-desktop-app\YouTube Music Desktop App.exe"
RWin & [::Run "C:\ProgramData\chocolatey\bin\emacsclientw.exe" -c -n -e "(gusev/org-gtd)"
RWin & ]::Run "C:\ProgramData\chocolatey\bin\emacsclientw.exe" -c -n -e "(gusev/org-capture-system-wide)"
