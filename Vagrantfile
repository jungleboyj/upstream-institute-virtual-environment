Vagrant.configure(2) do |config|
    config.vm.hostname = "upstream-training"
    config.vm.box = "ubuntu/xenial64"
    config.vm.provider "virtualbox" do |vb|
        vb.memory = "5632"
        vb.cpus = 2
        vb.name = "upstream-training"
        vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
        vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
        vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
    end
    config.vm.provision :shell, inline: "/vagrant/install-base.sh",
        privileged: false, keep_color: true
    config.vm.provision :shell, inline: "/vagrant/install-gui.sh",
        privileged: false, keep_color: true
    config.vm.provision :shell, inline: "/vagrant/install-devstack.sh",
        privileged: false, keep_color: true
    config.vm.provision :shell, inline: "/vagrant/configure-vagrant.sh",
        privileged: false, keep_color: true
    config.vm.box_check_update = false
    config.ssh.forward_x11 = true
    config.ssh.forward_agent = true
end
