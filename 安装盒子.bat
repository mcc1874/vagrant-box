@echo off
set box_name=common_dev_1
set box_file=%cd%\\%box_name%.box
if exist %box_file% (
    vagrant box remove %box_name% 2>nul
    vagrant box add --name %box_name% %box_file%
    echo ��ʼ�����
) else (
    echo �Ҳ����ļ���%box_file%
)
pause