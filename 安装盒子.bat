@echo off
set box_name=common_dev_1
set box_file=%cd%\\%box_name%.box
if exist %box_file% (
    vagrant destroy 2>nul
    vagrant box remove %box_name% 2>nul
    vagrant box add --name %box_name% %box_file%
    echo initialization
) else (
    echo not found:%box_file%
)
pause