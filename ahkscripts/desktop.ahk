SetTitleMatchMode, RegEx

RWin::return

Ctrl & g::Send {Escape}

;RWin & y::Send {AppsKey}

RWin & h::Send {RWin down}{Tab}{RWin up}

RWin & j::AltTab
RWin & k::ShiftAltTab

RWin & 7::Send {RWin down}{LCtrl down}{Left}{RWin up}{LCtrl up}
RWin & 9::Send {RWin down}{LCtrl down}{Right}{RWin up}{LCtrl up}

RWin & n::WinClose, A
;RWin & n::Send {LAlt down}{F4}{LAlt up}
;RWin & n::
;  Send {LAlt down}{Space}{LAlt up}
;  Sleep 10
;  Send c
;  return

;RWin & 8::Send {RWin down}{Up}{RWin up}
;RWin & u::Send {RWin down}{Left}{RWin up}
;RWin & i::Send {RWin down}{Down}{RWin up}
;RWin & o::Send {RWin down}{Right}{RWin up}

;RWin & PgUp::Send {Volume_Up}
;RWin & PgDn::Send {Volume_Down}

;RWin & h::Send {RWin down}{Tab}{RWin up}

; http://superuser.com/questions/429930/using-capslock-to-switch-the-keyboard-language-layout#431302
;SetCapsLockState, AlwaysOff
;+CapsLock::CapsLock

Shift & Escape::Send, {LAlt down}{LShift down}{LShift up}{LAlt up}

Shift & CapsLock::Send, {LAlt down}{LShift down}{LShift up}{LAlt up}
return

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

#IfWinActive, ahk_exe ST Earth.exe
XButton1::Send {Space}
XButton2::Send {Tab}
#IfWinActive

#IfWinActive, ahk_exe stellaris.exe
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

;RWin & ]::Run "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --app=https://checkvist.com/checklists/657547
;RWin & ]::Run "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --app=https://dynalist.io/d/o5vd3YTzB05-chhPQm0NHuwK#z=GvcVrA_ZMaWX06ysNXvFpi_K
;RWin & [::Run "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"  --profile-directory=Default --app-id=apbhkicgdmkmphgheeacendjgegplhfo
;RWin & [::Run "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --app="https://dynalist.io/d/o5vd3YTzB05-chhPQm0NHuwK#z=N91SoqK9MlZU9ARh1Sy-ZN4R"
;RWin & F9::Run "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
;RWin & F12::Run "C:\Program Files\ConEmu\ConEmu64.exe"
