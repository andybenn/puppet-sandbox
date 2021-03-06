# -*- mode: ruby -*-
# vi: set ft=ruby :
domain = 'example.com'

puppet_nodes = [
  {:hostname => 'puppet',  :ip => '172.16.32.10', :box => 'debian', :fwdhost => 8140, :fwdguest => 8140, :ram => 512},
  {:hostname => 'client1', :ip => '172.16.32.11', :box => 'debian'},
  {:hostname => 'client2', :ip => '172.16.32.12', :box => 'debian'},
]

Vagrant.configure("2") do |config|
  config.vm.box = "trusty-server-cloudimg-amd64-vagrant-disk1"
  puppet_nodes.each do |node|
    config.vm.define node[:hostname] do |node_config|
#      node_config.vm.box = node[:box]
      node_config.vm.box_url = 'https://cloud-images.ubuntu.com/vagrant/trusty/current/'+config.vm.box+'.box'
      node_config.vm.hostname = node[:hostname] + '.' + domain
      node_config.vm.network :private_network, ip: node[:ip]

      if node[:fwdhost]
        node_config.vm.network :forwarded_port, guest: node[:fwdguest], host: node[:fwdhost]
      end

      memory = node[:ram] ? node[:ram] : 256;
      node_config.vm.provider :virtualbox do |vb|
        vb.customize [
          'modifyvm', :id,
          '--name', node[:hostname],
          '--memory', memory.to_s
        ]
      end

      node_config.vm.provision :puppet do |puppet|
        puppet.manifests_path = 'provision/manifests'
        puppet.module_path = 'provision/modules'
      end
    end
  end
end
