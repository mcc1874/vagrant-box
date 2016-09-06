@echo off
set "default_box_name=common_dev_1"
set /p "box_name=please input box name:(default:common_dev_1)"

if not defined box_name (
    set "box_name=%default_box_name%"
)

echo -------- please wait ---------
vagrant package --base %box_name% --output %cd%\\%box_name%.box
echo %cd%\\%box_name%.box
echo.
pause