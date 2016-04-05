SetWorkingDir E:\src\hms-dev\baweb
UnixWorkDir = /cygdrive/e/src/hms-dev/baweb

run ConEmu64.exe /dir %A_WorkingDir%
WinWaitActive ahk_class VirtualConsoleClass
Sleep 1000
Send {LCtrl down}t{LCtrl up}{AppsKey down}r{AppsKey up}unison{Enter}
Sleep 1000
Send cd %UnixWorkDir%{Enter}vagrant up && echo ./script/unison{Enter}
Sleep 1000
Send {LCtrl down}t{LCtrl up}{AppsKey down}r{AppsKey up}guard{Enter}
Sleep 1000
Send cd %UnixWorkDir%{Enter}sleep 20 && vagrant ssh{Enter}cd /vagrant/baweb && bundle exec guard{Enter}
Sleep 1000
Send {LCtrl down}t{LCtrl up}{AppsKey down}r{AppsKey up}vagrant{Enter}
Sleep 1000
Send cd %UnixWorkDir%{Enter}sleep 20 && vagrant ssh{Enter}
Sleep 1000
Send {LAlt down}1{LAlt up}
Sleep 1000
Send {LAlt down}{LWin down}{Right}{Right}{Right}{LWin up}{LAlt up}

run atom.cmd %A_WorkingDir%
