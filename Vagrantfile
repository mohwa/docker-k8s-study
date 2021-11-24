# -*- mode: ruby -*-
# vi: set ft=ruby :

## configuration variables ##
# max number of worker nodes
WORKER_COUNT = 3
# each of components to install

# Kubernetes 버전
K8S_VERSION = '1.20.2'
# Kubernetes minor 버전까지
K8S_MINOR_VERSION = K8S_VERSION[0..3]

# Docker
DOCKER_VERSION = '19.03.14-3.el7'
# Containerd
CONTAINERD_VERSION = '1.3.9-3.1.el7'
## /configuration variables ##

Vagrant.configure("2") do |config|

  #=============#
  # Master Node #
  #=============#

    config.vm.define "m-k8s-#{K8S_MINOR_VERSION}" do |cfg|
      cfg.vm.box = "sysnet4admin/CentOS-k8s"
      cfg.vm.provider "virtualbox" do |vb|
        vb.name = "m-k8s-#{K8S_MINOR_VERSION}(github_SysNet4Admin)"
        vb.cpus = 2
        # 1.7gb
        vb.memory = 1746
        vb.customize ["modifyvm", :id, "--groups", "/k8s-SgMST-#{K8S_MINOR_VERSION}(github_SysNet4Admin)"]
      end
      cfg.vm.host_name = "m-k8s"
      cfg.vm.network "private_network", ip: "192.168.56.10"
      cfg.vm.network "forwarded_port", guest: 22, host: 60010, auto_correct: true, id: "ssh"
      cfg.vm.synced_folder "../data", "/vagrant", disabled: true
      cfg.vm.provision "shell", path: "scripts/k8s_env_build.sh", args: WORKER_COUNT
      cfg.vm.provision "shell", path: "scripts/k8s_pkg_cfg.sh", args: [ K8S_VERSION, DOCKER_VERSION, CONTAINERD_VERSION ]
      cfg.vm.provision "shell", path: "scripts/master_node.sh"
    end

  #==============#
  # Worker Nodes #
  #==============#

  (1..WORKER_COUNT).each do |i|
    config.vm.define "w#{i}-k8s-#{K8S_MINOR_VERSION}" do |cfg|
      cfg.vm.box = "sysnet4admin/CentOS-k8s"
      cfg.vm.provider "virtualbox" do |vb|
        vb.name = "w#{i}-k8s-#{K8S_MINOR_VERSION}(github_SysNet4Admin)"
        vb.cpus = 1
        # 1gb
        vb.memory = 1024
        vb.customize ["modifyvm", :id, "--groups", "/k8s-SgMST-#{K8S_MINOR_VERSION}(github_SysNet4Admin)"]
      end
      cfg.vm.host_name = "w#{i}-k8s"
      cfg.vm.network "private_network", ip: "192.168.56.10#{i}"
      cfg.vm.network "forwarded_port", guest: 22, host: "6010#{i}", auto_correct: true, id: "ssh"
      cfg.vm.synced_folder "../data", "/vagrant", disabled: true
      cfg.vm.provision "shell", path: "scripts/k8s_env_build.sh", args: WORKER_COUNT
      cfg.vm.provision "shell", path: "scripts/k8s_pkg_cfg.sh", args: [ K8S_VERSION, DOCKER_VERSION, CONTAINERD_VERSION ]
      cfg.vm.provision "shell", path: "scripts/work_nodes.sh"
    end
  end
end