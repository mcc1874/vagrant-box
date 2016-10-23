Vagrant.configure(2) do |config|
	config.vm.box = "common_dev_1"

	config.vm.define :web do |web_config|
        web_config.vm.hostname = "web.vagrant.internal"
        web_config.vm.network :private_network, ip: "192.168.33.10"
        web_config.vm.provision :shell, path: "bootstrap.sh"
        web_config.vm.synced_folder "./www", "/home/www"
        web_config.vm.provider "virtualbox" do |vb|
            vb.name = "web"
            vb.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
            vb.customize ["modifyvm", :id, "--memory", "1100"]
            vb.customize ["modifyvm", :id, "--cpus", "1"]
            vb.cpus = 2
        end
    end
end