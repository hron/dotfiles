SetWorkingDir C:\Users\aleks\src\hms-dev\baweb
UnixWorkDir = ~/src/hms-dev/baweb

run ConEmu64.exe /dir %A_WorkingDir% /cmdlist bash.exe -li -c  "cd %UnixWorkDir%; vagrant up && ./script/unison; bash -li" -new_console:t:"unison" ||| bash.exe -li -c "cd %UnixWorkDir%; sleep 5; vagrant ssh -c 'cd /vagrant/baweb; bundle exec guard; bash -li'; bash -li" -new_console:t:"guard" ||| bash.exe -li -c "cd %UnixWorkDir%; atom.cmd .; bash -li"
