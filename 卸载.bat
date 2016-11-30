@echo off
set box_name=common_php
set box_file=%cd%\\%box_name%.box
if exist %box_file% (
    vagrant destroy 2>nul
    vagrant box remove %box_name% 2>nul
    echo success
) else (
    echo not found:%box_file%
)
pause