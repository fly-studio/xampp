@echo off
cd /D %~dp0

if not "%~1"=="" (
	if exist "%CD%\..\%~1" (
		echo 重建%CD%\..\%~1 的VC %~2 DLL库文件指向
		
		rem for /f "delims=" %%a in ('dir   /s /b /a-d^|findstr /v /i "mklink.bat"') do (echo %%a)
		for /f "delims=" %%d in ('dir /b /on "%CD%\%~2\ms*.dll" "%CD%\%~2\vc*.dll" "%CD%\%~2\api-*.dll" "%CD%\%~2\ucrtbase.dll"') do (
			rem	if exist %CD%\..\%%i\%%d (rmdir %CD%\..\%%i\%%d)
			mklink "%CD%\..\%~1\%%d" "%CD%\%~2\%%d" >nul
		)
		echo vc %~2 done!
		echo.

	)
)