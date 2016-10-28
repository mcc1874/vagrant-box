Vagrant.configure(2) do |config|
  config.vm.box = "common_php"

  config.vm.define :common_php do |web_config|
        web_config.vm.hostname = "common.php"
        config.vm.network :forwarded_port, guest: 80, host: 9999
        # web_config.vm.network :private_network, ip: "192.168.33.10"
        # web_config.vm.network "public_network", ip: "192.168.1.10"
        # web_config.vm.network "public_network", :bridge => "en1: Wi-Fi (AirPort)"
        web_config.vm.provision :shell, path: "bootstrap.sh"
        web_config.vm.synced_folder "./share", "/vagrant"
        web_config.vm.provider "virtualbox" do |vb|
            vb.name = "common_php"
            vb.customize ["modifyvm", :id, "--cpuexecutioncap", "100"]
            vb.customize ["modifyvm", :id, "--memory", "4096"]
            vb.customize ["modifyvm", :id, "--cpus", "2"]
        end
    end
end