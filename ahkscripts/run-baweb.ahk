SetWorkingDir E:\src\hms-dev\baweb
UnixWorkDir = /cygdrive/e/src/hms-dev/baweb

run ConEmu64.exe /dir %A_WorkingDir% /cmdlist sh.exe --login -i -new_console:t:unison ||| sh.exe --login -i -new_console:t:guard ||| sh.exe --login -i -new_console:t:vagrant ||| sh.exe --login -i -new_console:t:Thor
WinWaitActive ahk_class VirtualConsoleClass
Send {LAlt down}1{LAlt up}cd %UnixWorkDir%{Enter}vagrant up && ./script/unison{Enter}
Send {LAlt down}2{LAlt up}cd %UnixWorkDir%{Enter}sleep 10 && vagrant ssh{Enter}cd /vagrant/baweb && bundle exec guard{Enter}
Send {LAlt down}3{LAlt up}cd %UnixWorkDir%{Enter}sleep 10 && vagrant ssh{Enter}
Send {LAlt down}4{LAlt up}cd %UnixWorkDir%{Enter}git status{Enter}
Send {LAlt down}1{LAlt up}

run atom.cmd %A_WorkingDir%
