@echo off
set sync_dir=d://www
set vagrantfile_name=Vagrantfile
set vagrantfile_file=%cd%\\%vagrantfile_name%
if exist %vagrantfile_file% (
    md "%sync_dir%" 2>nul
    vagrant halt 2>nul
    vagrant up
) else (
    echo 找不到文件：%vagrantfile_file%
)
pause