@echo off
cd /D %~dp0

if not "%~1"=="" (
	if exist "%CD%\..\%~1" (
		echo 清除%CD%\..\%~1 的公共DLL库文件指向
		for /f "tokens=3,4 delims= " %%c in ('dir "%CD%\..\%~1" ^| FIND "<SYMLINK"') do (
			if "%%c" == "<SYMLINKD>" (rmdir "%CD%\..\%~1\%%d") else (del "%CD%\..\%~1\%%d")
		)
	)
)