@echo off
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
set  i=apache\bin
call :link %i%

rem 建立php的指向
for /f "delims=" %%i in ('dir /b /a:d /on "%CD%\..\php.*" ^|findstr /i "php."') do (
	rem 完整路径为 %%~ti%%~dpnxi
	call :link %%i
	
)
goto :exit

:link
if not "%1"=="" (
	echo %1
	if exist "%CD%\..\%1" (
		echo 重建%CD%\..\%1的公共DLL库文件指向
		for /f "tokens=3,4 delims= " %%c in ('dir "%CD%\..\%1" ^| FIND "<SYMLINK"') do (
			if "%%c" == "<SYMLINKD>" (rmdir "%CD%\..\%1\%%d") else (del "%CD%\..\%1\%%d")
		)
		rem for /f "delims=" %%a in ('dir   /s /b /a-d^|findstr /v /i "mklink.bat"') do (echo %%a)
		for /f "delims=" %%d in ('dir /b /on "%CD%\*.dll" "%CD%\*.pdb"') do (
			rem	if exist %CD%\..\%%i\%%d (rmdir %CD%\..\%%i\%%d)
			mklink "%CD%\..\%1\%%d" "%CD%\%%d" >nul
		)
		echo done!
		echo.

	)
)
	
goto :EOF
 
:exit
echo.
echo 公共DLL库指向操作已完成
echo.
if not "%1"=="setup" (
pause>nul
)