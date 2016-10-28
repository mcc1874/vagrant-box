## 前置条件
- [安装VirtualBox](http://download.virtualbox.org/virtualbox/5.1.8/VirtualBox-5.1.8-111374-Win.exe)
- [安装Vagrant](https://www.vagrantup.com/downloads.html)
- 安装vagrant-vbguest 启动cmd > vagrant plugin install vagrant-vbguest
- [安装xshell](http://www.netsarang.com/download/down_xsh.html)
- [下载centos 6.8](http://mirrors.163.com/centos/6.8/isos/x86_64/CentOS-6.8-x86_64-minimal.iso)    
    

    
    
## 如何创建虚拟机（以创建centos 6.x 虚拟机为例）
```
配置信息：
    名称：common_dev_1
    类型：Linux
    版本：Red Hat 64bit
    内存：2048MB
    硬盘: 30GB动态大小
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
输入命令：yum -y install gcc kernel-devel binutils curl httpd-tools wget screen


关闭iptables
输入命令：chkconfig iptables off && chkconfig ip6tables off

关闭selinux
输入命令：sed -i -e 's/^SELINUX=.*/SELINUX=permissive/' /etc/selinux/config

SSH免登录证书
输入命令：useradd vagrant && mkdir -m 0700 -p /home/vagrant/.ssh && wget https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub -O /home/vagrant/.ssh/authorized_keys && chmod 600 /home/vagrant/.ssh/authorized_keys && chown -R vagrant:vagrant /home/vagrant/.ssh
输入命令：sed -i 's/^\(Defaults.*requiretty\)/#\1/' /etc/sudoers && echo "vagrant ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

配置网卡
输入命令：cat << EOF > /etc/sysconfig/network-scripts/ifcfg-eth0
DEVICE=eth0
TYPE=Ethernet
ONBOOT=yes
NM_CONTROLLED=no
BOOTPROTO=dhcp
EOF

输入命令：cat << EOF > /etc/sysconfig/network-scripts/ifcfg-eth1
DEVICE=eth1
TYPE=Ethernet
ONBOOT=yes
NM_CONTROLLED=no
BOOTPROTO=dhcp
EOF

输入命令：cat << EOF > /etc/sysconfig/network-scripts/ifcfg-eth2
DEVICE=eth2
TYPE=Ethernet
ONBOOT=yes
NM_CONTROLLED=no
BOOTPROTO=dhcp
EOF


安装 VBoxGuestAdditions（可选）
安装了 VBoxGuestAdditions 后才可以使用共享目录的功能。到 VirtualBox 目录上传 VBoxGuestAdditions.iso 文件上传到 vagrant 用户目录。然后执行下面的命令:

输入命令：cd /tmp
输入命令：sudo mount -o loop /home/vagrant/VBoxGuestAdditions_{VBOX_VERSION}.iso /mnt
输入命令：sudo /mnt/VBoxLinuxAdditions.run && sudo umount /mnt && rm -rf /home/vagrant/VBoxGuestAdditions_*.iso
注：{VBOX_VERSION} 表示下载的版本号

安装lnmp（可选）
输入命令：yum -y install screen && screen -S lnmp
输入命令：yum -y install wget && wget -c ftp://soft.vpser.net/lnmp/lnmp1.3-full.tar.gz && tar zxf lnmp1.3-full.tar.gz && cd lnmp1.3-full && ./install.sh lnmp
输入命令：./addons.sh install redis 
输入命令：./addons.sh install memcached
输入命令：./addons.sh install imagemagick
输入命令：sed -i 's/sendfile   on/sendfile off/g' /usr/local/nginx/conf/nginx.conf

开启mysql远程（可选）
输入命令：mysql -u root -p
mysql> use mysql; 
mysql> update user set host = '%' where user = 'root';
mysql> flush privileges;

删除网络规则
输入命令：rm -f /etc/udev/rules.d/70-persistent-net.rules

清理lnmp.zip（可选）
输入命令：cd ~ && rm -rf lnmp*

清理体积
输入命令：yum -y erase gtk2 libX11 hicolor-icon-theme avahi freetype bitstream-vera-fonts && yum -y clean all && dd if=/dev/zero of=/EMPTY bs=1M
输入命令：rm -rf /EMPTY && rm -rf /tmp/* && rm -rf /var/log/wtmp /var/log/btmp && history -c

关机
输入命令：shutdown -h now
```


##FAQ：
###theme x64 bug
```
替换原生dll
```

###ssh权限错误
```
检查authorized_keys 所有人 权限600 大小409
注：和vagrant连接过的authorized_keys大小为389　原始大小为409
ll -a /home/vagrant/.ssh

先用修复chmod 600 /home/vagrant/.ssh/authorized_keys

修复不行，重新生成服务端authorized_keys
输入命令：mkdir -m 0700 -p /home/vagrant/.ssh && wget https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub -O /home/vagrant/.ssh/authorized_keys && chmod 600 /home/vagrant/.ssh/authorized_keys && chown -R vagrant:vagrant /home/vagrant/.ssh

检查本机vagrant ssh-config IdentityFile 路径的文件内容是否正确　53s=结尾
正确私钥：https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant
```