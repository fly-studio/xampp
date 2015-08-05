@echo off

if not ""%1"" == ""START"" goto stop

"D:\Server\xampp\apache\bin\httpd.exe"

if errorlevel 255 goto finish
if errorlevel 1 goto error
goto finish

:stop
"D:\Server\xampp\apache\bin\pv" -f -k httpd.exe -q
if not exist "D:\Server\xampp\apache\logs\httpd.pid" GOTO finish
del "D:\Server\xampp\apache\logs\httpd.pid"
goto finish

:error
echo Error starting Apache

:finish
exit
