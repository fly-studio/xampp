@echo off
cd /D %~dp0

echo -----------------------------------------
echo       选择一个准备安装的PHP环境
echo -----------------------------------------
echo.


if exist "%CD%\php\" (
	set /p i=PHP当前版本为: <nul
	for /f "tokens=2 delims=[]" %%i in ('dir "%CD%" ^| FIND "<SYMLINK"') do echo %%i
	echo.
)

:main
echo 请输入需要切换PHP的版本
set /p version=(比如：5.2 5.3 5.4，5.5，5.6，7.0，7.1，7.2，7.3)：

echo.

if exist "%CD%\php.%version%\" (
	goto php
) else (
	echo 没有找到对应PHP版本文件&goto main
)



:php
echo.
echo 正在关闭apache进程...
call %CD%\apache_stop.bat
echo.
echo 正在切换PHP版本为 %version%
if exist "%CD%\php\" (rmdir "%CD%\php\")
mklink /D "%CD%\php\" "%CD%\php.%version%\"

if "%version%" GEQ "7.0"  (
	copy /y "%CD%\apache\conf\extra\httpd-xampp7" "%CD%\apache\conf\extra\httpd-xampp.conf"
) else (
	copy /y "%CD%\apache\conf\extra\httpd-xampp5" "%CD%\apache\conf\extra\httpd-xampp.conf"
)


echo.
echo  -----------------------------------------
echo        PHP安装已经完成，请启动Apache
echo  您可以随时在根目录中运行switch_php.bat进行切换
echo  -----------------------------------------

:exit
echo.
if not "%1"=="setup" (
pause>nul
)