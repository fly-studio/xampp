@echo off
cd /D %~dp0

if not "%~1"=="" (
	if exist "%CD%\..\%~1" (
		echo ���%CD%\..\%~1 �Ĺ���DLL���ļ�ָ��
		for /f "tokens=3,4 delims= " %%c in ('dir "%CD%\..\%~1" ^| FIND "<SYMLINK"') do (
			if "%%c" == "<SYMLINKD>" (rmdir "%CD%\..\%~1\%%d") else (del "%CD%\..\%~1\%%d")
		)
	)
)