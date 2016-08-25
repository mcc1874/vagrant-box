@echo off
set virt_name=common_dev_1 rem 虚拟机名称
set box_name=common_dev_1  rem 盒子名称

echo -------- 正在生成，请耐心等待 ---------
vagrant package --base %virt_name% --output %cd%\\%box_name%.box
pause
