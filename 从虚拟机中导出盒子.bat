@echo off
set "default_box_name=common_dev_1"     rem 默认盒子名称
set /p "box_name=请输入要导出的盒子名称（默认common_dev_1）:"

if not defined box_name (
    set "box_name=%default_box_name%"
)

echo -------- 正在生成，请耐心等待 ---------
vagrant package --base %box_name% --output %cd%\\%box_name%.box
echo %cd%\\%box_name%.box
echo.
pause