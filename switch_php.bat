@echo off
cd /D %~dp0

echo -----------------------------------------
echo       ѡ��һ��׼����װ��PHP����
echo -----------------------------------------
echo.


if exist "%CD%\php\" (
	set /p i=PHP��ǰ�汾Ϊ: <nul
	for /f "tokens=2 delims=[]" %%i in ('dir "%CD%" ^| FIND "<SYMLINK"') do echo %%i
	echo.
)

:main
echo ��������Ҫ�л�PHP�İ汾
set /p version=(���磺5.2 5.3 5.4��5.5��5.6��7.0��7.1��7.2��7.3)��

echo.

if exist "%CD%\php.%version%\" (
	goto php
) else (
	echo û���ҵ���ӦPHP�汾�ļ�&goto main
)



:php
echo.
echo ���ڹر�apache����...
call %CD%\apache_stop.bat
echo.
echo �����л�PHP�汾Ϊ %version%
if exist "%CD%\php\" (rmdir "%CD%\php\")
mklink /D "%CD%\php\" "%CD%\php.%version%\"

if "%version%" GEQ "7.0"  (
	copy /y "%CD%\apache\conf\extra\httpd-xampp7" "%CD%\apache\conf\extra\httpd-xampp.conf"
) else (
	copy /y "%CD%\apache\conf\extra\httpd-xampp5" "%CD%\apache\conf\extra\httpd-xampp.conf"
)


echo.
echo  -----------------------------------------
echo        PHP��װ�Ѿ���ɣ�������Apache
echo  ��������ʱ�ڸ�Ŀ¼������switch_php.bat�����л�
echo  -----------------------------------------

:exit
echo.
if not "%1"=="setup" (
pause>nul
)