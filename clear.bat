@echo off
cd /D %~dp0

:main

echo 清理LOG文件、软链接文件
echo.
echo 以下操作将会关闭Apache、MySQL
echo 任意键继续...
echo.
if not "%1"=="setup" (
pause>nul
)

echo 关闭Apache进程
call %CD%\apache_stop.bat
echo.
echo 关闭MySQL进程
call %CD%\mysql_stop.bat

echo.
echo 清除log文件中...

echo off  >"%CD%\apache\logs\access.log"
echo off  >"%CD%\apache\logs\error.log"
echo off  >"%CD%\apache\logs\ssl_request.log"
del %CD%\apache\conf\extra\httpd-xampp.conf
if exist "%CD%\xampp-control.log" (del "%CD%\xampp-control.log")

for /f "delims=" %%i in ('dir /b /a:d /on "%CD%\php.*" ^|findstr /i "php."') do (
	rem 完整路径为 %%~ti%%~dpnxi
	echo off >"%CD%\%%i\logs\php_error_log"
)
echo done!

echo.
echo 清理symlink文件中...
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
	echo 清理%CD%\%1
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
echo 清理操作已完成
echo.
if not "%1"=="setup" (
pause>nul
)