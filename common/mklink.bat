@echo off
setlocal EnableDelayedExpansion
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
set i=apache\bin
call clear.bat %i%
call linkvc.bat %i% x64

rem ����php��ָ��
for /f "delims=" %%i in ('dir /b /a:d /on "%CD%\..\php.*" ^|findstr /i "php."') do (

	rem ����·��Ϊ %%~ti%%~dpnxi
	
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
echo ����DLL��ָ����������
echo.
if not "%1"=="setup" (
pause>nul
)