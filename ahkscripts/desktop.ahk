~RWin Up:: return

RWin & Space:: Send {LWin up}

RWin & j::AltTab
RWin & k::ShiftAltTab

RWin & u::Send {RWin down}{Left}{RWin up}
RWin & i::Send {RWin down}{Down}{RWin up}
RWin & o::Send {RWin down}{Right}{RWin up}
RWin & 8::Send {RWin down}{Up}{RWin up}

RWin & 7::Send {RWin down}{LCtrl down}{Left}{RWin up}{LCtrl up}
RWin & 9::Send {RWin down}{LCtrl down}{Right}{RWin up}{LCtrl up}

RWin & n::
  if WinActive("ahk_class VirtualConsoleClass") {
    WinClose
  } else {
    Send {LAlt down}{F4}{LAlt up}
  }
  return

RWin & m::Send {LAlt down}{Space}{LAlt up}x
RWin & ,::Send {LAlt down}{Space}{LAlt up}n

RWin & PgUp::Send {Volume_Up}
RWin & PgDn::Send {Volume_Down}

RWin & h::Send {RWin down}{Tab}{RWin up}

RWin & -::
  IfWinNotExist ahk_class Kodi
    return
  ControlSend, ahk_parent, {Space down}{Space up}
  return

; Fix Ctrl-Backspace and Ctrl-Delete in ConEmu
Ctrl & Backspace::
  if WinActive("ahk_class VirtualConsoleClass") {
    Send {LCtrl down}w{LCtrl up}
  } else {
    Send {LCtrl down}{Backspace down}{Backspace up}{LCtrl up}
  }
  return
Ctrl & Delete::
  if WinActive("ahk_class VirtualConsoleClass") {
    Send {LAlt down}d{LAlt up}
  } else {
    Send {LCtrl down}{Delete}{LCtrl up}
  }
  return

; Fix Ctrl-Arrows in ConEmu
Ctrl & Left::
  if WinActive("ahk_class VirtualConsoleClass") {
    Send {LAlt down}b{LAlt up}
  } else {
    Send {LCtrl down}{Left}{LCtrl up}
  }
  return
Ctrl & Right::
  if WinActive("ahk_class VirtualConsoleClass") {
    Send {LAlt down}f{LAlt up}
  } else {
    Send {LCtrl down}{Right}{LCtrl up}
  }
  return
