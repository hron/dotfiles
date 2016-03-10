~RWin Up:: return

RWin & Space:: Send {LWin up}

RWin & j::AltTab
RWin & k::ShiftAltTab

RWin & 7::Send {RWin down}{LCtrl down}{Left}{RWin up}{LCtrl up}
RWin & 9::Send {RWin down}{LCtrl down}{Right}{RWin up}{LCtrl up}

;RWin & n::WinClose, A
;RWin & n::Send {LAlt down}{F4}{LAlt up}
RWin & n::
  Send {LAlt down}{Space}{LAlt up}
  Sleep 10
  Send c
  return
RWin & m::WinMaximize, A
;RWin & ,::WinMinimize, A
RWin & ,::
  Send {LAlt down}{Space}{LAlt up}
  Sleep 10
  Send n
  return

RWin & PgUp::Send {Volume_Up}
RWin & PgDn::Send {Volume_Down}

RWin & h::Send {RWin down}{Tab}{RWin up}

RWin & -::
  IfWinNotExist ahk_class Kodi
    return
  ControlSend, ahk_parent, {Space down}{Space up}
  return

#IfWinActive, ahk_class VirtualConsoleClass
Ctrl & Left::Send {LAlt down}b{LAlt up}
Ctrl & Right::Send {LAlt down}f{LAlt up}
Ctrl & Backspace::Send {LAlt down}{Backspace}{LAlt up}
Ctrl & Delete::Send {LAlt down}d{LAlt up}
Shift & PgUp::Send {LCtrl down}{PgUp down}{PgUp up}{LCtrl up}
Shift & PgDn::Send {LCtrl down}{PgDn down}{PgDn up}{LCtrl up}
;Ctrl & PgUp::Send {LCtrl down}{Tab down}{Tab up}{LCtrl up}
;Ctrl & PgDn::Send {LCtrl down}{LShift down}{Tab down}{Tab up}{LShift up}{LCtrl up}
#IfWinActive

; Graviteam Tactics: Mius-Front
#IfWinActive, ahk_class i_window
XButton1::MButton
#IfWinActive
