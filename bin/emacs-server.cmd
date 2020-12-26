:: Starts server and org-gtd

@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

PUSHD "%~dp0" >NUL

start runemacs --eval "(progn (server-start) (gusev/org-gtd))"

POPD >NUL
ECHO ON
