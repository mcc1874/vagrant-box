@echo off
set "default_box_name=common_dev_1"     rem Ĭ�Ϻ�������
set /p "box_name=������Ҫ�����ĺ������ƣ�Ĭ��common_dev_1��:"

if not defined box_name (
    set "box_name=%default_box_name%"
)

echo -------- �������ɣ������ĵȴ� ---------
vagrant package --base %box_name% --output %cd%\\%box_name%.box
echo %cd%\\%box_name%.box
echo.
pause