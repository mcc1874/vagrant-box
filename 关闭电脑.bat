@echo off
set vagrantfile_name=Vagrantfile
set vagrantfile_file=%cd%\\%vagrantfile_name%
if exist %vagrantfile_file% (
    vagrant halt
)
shutdown -f -s -t 5
pause