@echo off
set virt_name=common_dev_1 rem ���������
set box_name=common_dev_1  rem ��������

echo -------- �������ɣ������ĵȴ� ---------
vagrant package --base %virt_name% --output %cd%\\%box_name%.box
pause
