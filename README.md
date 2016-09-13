## 前置条件
- [安装VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [安装Vagrant](https://www.vagrantup.com/downloads.html)
- 安装vagrant-vbguest 启动cmd > vagrant plugin install vagrant-vbguest
- [安装xshell](http://www.netsarang.com/download/down_xsh.html)
- [下载centos 6.8](http://mirrors.163.com/centos/6.8/isos/i386/CentOS-6.8-i386-minimal.iso)    
    

    
    
## 如何创建虚拟机（以创建centos 6.x 虚拟机为例）
```
配置信息：
    名称：common_dev_1
    类型：Linux
    版本：Red Hat 32bit
    内存：1100MB
    硬盘: 40GB
    系统：去掉软驱勾选
    声音: 去掉声音勾选
    USB设备: 去掉USB设备勾选
    网络:
        网卡1, 网络地址转换(NAT)
        网卡2, 仅主机(Host-Only)适配器
        网卡3, 桥接网卡
    设置root密码：vagrant

登录：
login:root
password:vagrant

输入命令：dhclient   //初始化网络
输入命令：ip addr    //查看ip
```




##Xshell连接虚拟机
```
配置信息 192.168.56.101 root vagrant
后续操作全部在xshell完成

安装必需的包
输入命令：yum -y install kernel kernel-devel binutils curl

关闭iptables
输入命令：chkconfig iptables off && chkconfig ip6tables off

关闭selinux
输入命令：sed -i -e 's/^SELINUX=.*/SELINUX=permissive/' /etc/selinux/config

SSH免登录证书
输入命令：useradd vagrant && mkdir -m 0700 -p /home/vagrant/.ssh && curl https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub >> /home/vagrant/.ssh/authorized_keys && chmod 600 /home/vagrant/.ssh/authorized_keys && chown -R vagrant:vagrant /home/vagrant/.ssh
输入命令：sed -i 's/^\(Defaults.*requiretty\)/#\1/' /etc/sudoers && echo "vagrant ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

配置网卡
输入命令：cat << EOF1 > /etc/sysconfig/network-scripts/ifcfg-eth0
DEVICE=eth0
TYPE=Ethernet
ONBOOT=yes
NM_CONTROLLED=no
BOOTPROTO=dhcp
EOF1

输入命令：cat << EOF1 > /etc/sysconfig/network-scripts/ifcfg-eth1
DEVICE=eth1
TYPE=Ethernet
ONBOOT=yes
NM_CONTROLLED=no
BOOTPROTO=dhcp
EOF1

输入命令：cat << EOF1 > /etc/sysconfig/network-scripts/ifcfg-eth2
DEVICE=eth2
TYPE=Ethernet
ONBOOT=yes
NM_CONTROLLED=no
BOOTPROTO=dhcp
EOF1

安装lnmp（可选）
输入命令：yum -y install screen && screen -S lnmp
输入命令：yum -y install wget && wget -c http://soft.vpser.net/lnmp/lnmp1.3-full.tar.gz && tar zxf lnmp1.3-full.tar.gz && cd lnmp1.3-full && ./install.sh lnmp
输入命令：./addons.sh install redis 
输入命令：vi /usr/local/nginx/conf/nginx.conf
    "sendfile on" 修改为 "sendfile off"
    防止静态文件缓存


删除日志
输入命令：rm -f /etc/udev/rules.d/70-persistent-net.rules && yum clean all && rm -rf /tmp/* && rm -f /var/log/wtmp /var/log/btmp && history -c

关机
输入命令：shutdown -h now
```



##从虚拟机中导出盒子.bat
```bat
@echo off
set "default_box_name=common_dev_1"
set /p "box_name=please input box name:(default:common_dev_1)"

if not defined box_name (
    set "box_name=%default_box_name%"
)

echo -------- please wait ---------
vagrant package --base %box_name% --output %cd%\\%box_name%.box
echo %cd%\\%box_name%.box
pause
```




##安装盒子.bat
```bat
@echo off
set box_name=common_dev_1
set box_file=%cd%\\%box_name%.box
if exist %box_file% (
    vagrant destroy 2>nul
    vagrant box remove %box_name% 2>nul
    vagrant box add --name %box_name% %box_file%
    echo success
) else (
    echo not found:%box_file%
)
pause
```



##启动盒子.bat
```bat
@echo off
set vagrantfile_name=Vagrantfile
set vagrantfile_file=%cd%\\%vagrantfile_name%
if exist %vagrantfile_file% (
    vagrant halt 2>nul
    vagrant up --provision
) else (
    echo not found:%vagrantfile_file%
)
pause
```



##关闭盒子.bat
```bat
@echo off
set vagrantfile_name=Vagrantfile
set vagrantfile_file=%cd%\\%vagrantfile_name%
if exist %vagrantfile_file% (
    vagrant halt
) else (
    echo not found:%vagrantfile_file%
)
pause
```

##Vagrantfile
```
Vagrant.configure(2) do |config| 

config.vm.box = "common_dev_1"

#启动时执行该脚本
config.vm.provision :shell, path: "bootstrap.sh"

#端口转发
#config.vm.network :forwarded_port, guest: 80, host: 8080

#私有网络，只有主机可以访问虚拟机
config.vm.network :private_network, ip: "192.168.56.10"

#公有网络，局域网成员可访问
#config.vm.network :public_network, ip: "192.168.1.10"

#桥接网卡
#config.vm.network :public_network, :bridge => "en1: Wi-Fi (AirPort)"

#同步本地www至服务器www目录
config.vm.synced_folder "./www", "/home/www"
end
```



##连接新的盒子虚拟机
```
ip：192.168.56.10
login：root
passwd：vagrant
```
