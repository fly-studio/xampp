@echo off
cd /D %~dp0

set config=%appdata%\Notepad++\plugins\config\npes_saved.txt

if exist "%config%" (
	if not exist "%congfig%.original" (rename "%config%" "npes_saved.txt.original")
)
copy /Y "%CD%\npes_saved.txt" "%config%"

echo �Ѿ����ݲ�����npes_saved.txt

pause>nul