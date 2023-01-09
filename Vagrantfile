
Vagrant.configure("2") do |config|
  
  nodes = [
    { :hostname => 'appserver', :ip => '192.168.56.2'},
    { :hostname => 'dbserver',  :ip => '192.168.56.3'}
  ]

  # virtualbox provider ==> --provider=virtualbox
  nodes.each do |node|
      config.vm.define node[:hostname] do |nodeconfig|
        nodeconfig.vm.box = "bento/ubuntu-18.04"
        nodeconfig.vm.hostname = node[:hostname]
        nodeconfig.vm.network :private_network, ip: node[:ip]
    end
  end

  # digital_ocean provider ==>  --provider=digital_ocean
  config.vm.provider :digital_ocean do |provider, override|
    override.ssh.private_key_path = '~/.ssh/myvagrantkey'
    override.vm.box = 'digital_ocean'
    override.vm.box_url = "https://github.com/devopsgroup-io/vagrant-digitalocean/raw/master/box/digital_ocean.box"
    override.vm.allowed_synced_folder_types = :rsync

    provider.token = ENV['DTOKEN']  # export the token on terminal first
    provider.image = 'ubuntu-18-04-x64'
    provider.region = 'nyc1'
    provider.size = 's-1vcpu-1gb'
    provider.setup = false
  end

  ####### Install Puppet Agent #######
  config.puppet_install.puppet_version = :latest

  # provisioning
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file = "default.pp"
    puppet.module_path = "puppet/modules"
  end

end