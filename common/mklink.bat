@echo off
cd /D %~dp0

:main
echo -----------------------------------------
echo        �ؽ������й���DLL���ָ��
echo      ����VC����ʱ��Imagick���ļ���
echo -----------------------------------------
echo.
if not "%1"=="setup" (
echo [ȷ��]�밴�����,[�˳�]��رմ���
pause>nul
)

echo.


rem ����apache\bin��ָ��
set  i=apache\bin
call :link %i%

rem ����php��ָ��
for /f "delims=" %%i in ('dir /b /a:d /on "%CD%\..\php.*" ^|findstr /i "php."') do (
	rem ����·��Ϊ %%~ti%%~dpnxi
	call :link %%i
	
)
goto :exit

:link
if not "%1"=="" (
	echo %1
	if exist "%CD%\..\%1" (
		echo �ؽ�%CD%\..\%1�Ĺ���DLL���ļ�ָ��
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
echo ����DLL��ָ����������
echo.
if not "%1"=="setup" (
pause>nul
)