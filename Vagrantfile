Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/bionic64'
  config.vm.network :forwarded_port, guest: 4000, host: 4000, host_ip: '127.0.0.1'

  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', 2048]
    vb.customize ['modifyvm', :id, '--cpus', 2]
    vb.customize ['modifyvm', :id, '--ioapic', 'on']
    vb.customize ['setextradata', :id, 'VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root', '1']
  end

  config.vm.provision :chef_solo do |chef|
    chef.arguments = '--chef-license accept'
    chef.add_recipe 'devenv'
  end
end
