@echo off
set /p "input=reset hosts (input 1):"
if %input% == 1 (
	echo. >> C:\\Windows\\System32\\drivers\\etc\\hosts
	echo # 本地 >> C:\\Windows\\System32\\drivers\\etc\\hosts
	echo 127.0.0.1 www.admin-akdm.com >> C:\\Windows\\System32\\drivers\\etc\\hosts
	echo 127.0.0.1 www.akdm.com >> C:\\Windows\\System32\\drivers\\etc\\hosts
	echo 127.0.0.1 class.akdm.com >> C:\\Windows\\System32\\drivers\\etc\\hosts
	echo # 内网 >> C:\\Windows\\System32\\drivers\\etc\\hosts
	echo 192.168.1.11 test-akdm.com www.test-akdm.com test-admin-akdm.com www.test-admin-akdm.com >> C:\\Windows\\System32\\drivers\\etc\\hosts
	echo success
) 
pause