@echo off
echo -------- ע�⣬��ɾ�����еĺ��� ---------
pause
for /f %%c in ('dir /b *.box') do (
    vagrant box remove %%c
    vagrant box add --name %%c %cd%\\%%c
)
pause