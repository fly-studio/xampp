@echo off
setlocal EnableDelayedExpansion
cd /D %~dp0

:main
echo -----------------------------------------
echo        重建立所有公共DLL库的指向
echo      包含VC运行时，Imagick库文件等
echo -----------------------------------------
echo.
if not "%1"=="setup" (
echo [确定]请按任意键,[退出]请关闭窗口
pause>nul
)

echo.


rem 建立apache\bin的指向
set i=apache\bin
call clear.bat %i%
call linkvc.bat %i% x64

rem 建立php的指向
for /f "delims=" %%i in ('dir /b /a:d /on "%CD%\..\php.*" ^|findstr /i "php."') do (

	rem 完整路径为 %%~ti%%~dpnxi
	
	set version=x86

	set php=%%i

	if !php:~4! GEQ 7.2 (
		set version=x64
	)
	
	echo !php:~4! !version!

	call clear.bat %%~i
	call linkvc.bat %%~i !version!
	call linkimagick.bat %%~i !version!
)
goto exit

 
:exit
echo.
echo 公共DLL库指向操作已完成
echo.
if not "%1"=="setup" (
pause>nul
)