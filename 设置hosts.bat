@echo off
set /p "input=reset hosts (input 1):"
if %input% == 1 (
	echo. >> C:\\Windows\\System32\\drivers\\etc\\hosts
	echo # 本地 >> C:\\Windows\\System32\\drivers\\etc\\hosts
	echo 192.168.33.10 www.test.com >> C:\\Windows\\System32\\drivers\\etc\\hosts
	echo success
) 
pause