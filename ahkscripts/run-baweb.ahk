SetWorkingDir E:\src\hms-dev\baweb
UnixWorkDir = /cygdrive/e/src/hms-dev/baweb

run ConEmu64.exe /dir %A_WorkingDir%
WinWaitActive ahk_class VirtualConsoleClass
Sleep 20
Send {LCtrl down}t{LCtrl up}{AppsKey down}r{AppsKey up}unison{Enter}
Send cd %UnixWorkDir%{Enter}vagrant up && echo ./script/unison{Enter}
Send {LCtrl down}t{LCtrl up}{AppsKey down}r{AppsKey up}guard{Enter}
Send cd %UnixWorkDir%{Enter}sleep 20 && vagrant ssh{Enter}cd /vagrant/baweb && bundle exec guard{Enter}
Send {LCtrl down}t{LCtrl up}{AppsKey down}r{AppsKey up}vagrant{Enter}
Send cd %UnixWorkDir%{Enter}sleep 20 && vagrant ssh{Enter}
Send {LAlt down}1{LAlt up}
Send {LAlt down}{LWin down}{Right}{Right}{Right}{LWin up}{LAlt up}

run atom.cmd %A_WorkingDir%
