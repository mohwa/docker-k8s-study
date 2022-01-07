# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  #=============#
  # docker test VM #
  #=============#

    config.vm.define "centos7_env" do |cfg|
      cfg.vm.box = "centos/7"
      cfg.vm.provider "virtualbox" do |vb|
        vb.name = "docker_test"
        vb.cpus = 2
        vb.memory = 1024
        # VM 그룹 설정
        # vb.customize ["modifyvm", :id, "--groups", "/k8s-SgMST-#{K8S_MINOR_VERSION}(github_SysNet4Admin)"]
      end
      cfg.vm.host_name = "docker-test"
      cfg.vm.network "private_network", ip: "192.168.56.11"
      cfg.vm.network "forwarded_port", guest: 22, host: 60011, auto_correct: true, id: "ssh"
      cfg.vm.synced_folder "../data", "/vagrant", disabled: true
      cfg.vm.provision "shell", path: "scripts/pkg_install.sh", args: []
    end
end
