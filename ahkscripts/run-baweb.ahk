SetWorkingDir E:\src\hms-dev\baweb
UnixWorkDir = ~/src/hms-dev/baweb

run ConEmu64.exe /dir %A_WorkingDir% /cmdlist C:\cygwin64\bin\sh.exe --login -i -c  "cd %UnixWorkDir%; vagrant up && ./script/unison" -new_console:t:"unison" ||| C:\cygwin64\bin\sh.exe --login -i -c "cd %UnixWorkDir%; sleep 5; vagrant ssh -c 'cd /vagrant/baweb; bundle exec guard; bash --login -i'" -new_console:t:"guard" ||| C:\cygwin64\bin\sh.exe --login -i
run atom.cmd E:\src\hms-dev\baweb
