@echo off
set sync_dir=d://www
set vagrantfile_name=Vagrantfile
set vagrantfile_file=%cd%\\%vagrantfile_name%
if exist %vagrantfile_file% (
    vagrant halt
) else (
    echo 找不到文件：%vagrantfile_file%
)
pause