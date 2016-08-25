@echo off
echo -------- 注意，将删除已有的盒子 ---------
pause
for /f %%c in ('dir /b *.box') do (
    vagrant box remove %%c
    vagrant box add --name %%c %cd%\\%%c
)
pause