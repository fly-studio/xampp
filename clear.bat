@echo off
cd /D %~dp0

:main

echo ����LOG�ļ����������ļ�
echo.
echo ���²�������ر�Apache��MySQL
echo ���������...
echo.
if not "%1"=="setup" (
pause>nul
)

echo �ر�Apache����
call %CD%\apache_stop.bat
echo.
echo �ر�MySQL����
call %CD%\mysql_stop.bat

echo.
echo ���log�ļ���...

echo off  >"%CD%\apache\logs\access.log"
echo off  >"%CD%\apache\logs\error.log"
echo off  >"%CD%\apache\logs\ssl_request.log"
del %CD%\apache\conf\extra\httpd-xampp.conf
if exist "%CD%\xampp-control.log" (del "%CD%\xampp-control.log")

for /f "delims=" %%i in ('dir /b /a:d /on "%CD%\php.*" ^|findstr /i "php."') do (
	rem ����·��Ϊ %%~ti%%~dpnxi
	echo off >"%CD%\%%i\logs\php_error_log"
)
echo done!

echo.
echo ����symlink�ļ���...
echo.
set  i=.
call :dellink %i%

set  i=apache\bin
call :dellink %i%

for /f "delims=" %%i in ('dir /b /a:d /on "%CD%\php.*" ^|findstr /i "php."') do (
	call :dellink %%i
	
)
goto exit

:dellink
if not "%1"=="" (
	echo ����%CD%\%1
	if exist "%CD%\%1" (
		for /f "tokens=3,4 delims= " %%c in ('dir "%CD%\%1" ^| FIND "<SYMLINK"') do (
			if "%%c" == "<SYMLINKD>" (rmdir %CD%\%1\%%d) else (del %CD%\%1\%%d)
		)
		for /f "tokens=3,4 delims= " %%c in ('dir "%CD%\%1" ^| FIND "CORE_RL"') do (
			del %CD%\%1\%%d
		)
		for /f "tokens=3,4 delims= " %%c in ('dir "%CD%\%1" ^| FIND "IM_MOD_RL"') do (
			del %CD%\%1\%%d
		)
		for /f "tokens=3,4 delims= " %%c in ('dir "%CD%\%1" ^| FIND "msvc"') do (
			del %CD%\%1\%%d
		)
		for /f "tokens=3,4 delims= " %%c in ('dir "%CD%\%1" ^| FIND "vcomp"') do (
			del %CD%\%1\%%d
		)
		echo done!
		echo.
	)
)
goto :EOF

:exit
echo.
echo ������������
echo.
if not "%1"=="setup" (
pause>nul
)