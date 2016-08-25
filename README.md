## 前置条件
- [安装xshell](http://www.netsarang.com/download/down_xsh.html)
- [安装VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [安装Vagrant](https://www.vagrantup.com/downloads.html)
- 安装vagrant-vbguest 启动cmd > vagrant plugin install vagrant-vbguest
    
    
    
    
## 如何创建虚拟机（以创建centos 6 虚拟机为例）
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
输入命令：yum -y install kernel kernel-devel curl

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

删除日志
输入命令：rm -f /etc/udev/rules.d/70-persistent-net.rules && yum clean all && rm -rf /tmp/* && rm -f /var/log/wtmp /var/log/btmp && history -c

关机
输入命令：shutdown -h now
```




##生成盒子
```bat
@echo off
set virt_name=common_dev_1 rem 虚拟机名称
set box_name=common_dev_1  rem 盒子名称

echo -------- 正在生成，请耐心等待 ---------
vagrant package --base %virt_name% --output %cd%\\%box_name%.box
pause
```bat




##安装盒子
```bat
@echo off
echo -------- 注意，将删除已有的盒子 ---------
pause
for /f %%c in ('dir /b *.box') do (
    vagrant box remove %%c
    vagrant box add --name %%c %cd%\\%%c
)
pause
```bat












