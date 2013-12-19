# -*- mode: ruby -*-
# vi: set ft=ruby :

# We'll mount the Chef::Config[:file_cache_path] so it persists between
# Vagrant VMs
host_cache_path = File.expand_path('../.cache', __FILE__)
guest_cache_path = '/tmp/vagrant-cache'
::Dir.mkdir(host_cache_path) unless ::Dir.exist?(host_cache_path)

confucius_root = ENV['CONFUCIUS_ROOT']
unless confucius_root
  warn "[\e[1m\e[31mERROR\e[0m]: Please set the 'CONFUCIUS_ROOT' " +
       'environment variable to point to the confucius repo'
  exit 1
end

default = {
  :user => ENV['OPSCODE_USER'] || ENV['USER'],
  :project => File.basename(Dir.getwd),

  # AWS stuff
  :aws_access_key_id => ENV['AWS_ACCESS_KEY_ID'],
  :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
  :aws_keypair => ENV['AWS_KEYPAIR'],
  :aws_private_key => ENV['EC2_PRIVATE_KEY']
}

VM_NODENAME = "vagrant-#{default[:user]}-#{default[:project]}"

Vagrant.require_plugin 'vagrant-berkshelf'
Vagrant.require_plugin 'vagrant-omnibus'

Vagrant.configure('2') do |config|
  # Berkshelf plugin configuration
  config.berkshelf.enabled = true

  # Omnibus
  config.omnibus.chef_version = :latest

  # Enable SSH agent forwarding for git clones
  config.ssh.forward_agent = true

  config.vm.hostname = 'localhost'

  config.vm.box = 'opscode-ubuntu-12.04'
  config.vm.box_url = 'https://opscode-vm.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_provisionerless.box'
  
  config.vm.network 'private_network', ip: '10.1.2.30'
  
  
  # virtualbox provider
  config.vm.provider :virtualbox do |vb|
#      vb.gui = true
      vb.customize ['modifyvm', :id, '--cpus', 2]
      vb.customize ['modifyvm', :id, '--memory', 1024]
  end
  
  # chef provision
  config.vm.provision :chef_solo do |chef|
    chef.log_level = :debug

    chef.data_bags_path = "#{confucius_root}/data_bags"

    chef.json = {
        :balanced_env => 'vagrant',
        :message_broker => '10.0.2.2',
        :citadel => {
            'newrelic/license_key' => nil,
            'access_key_id' => default[:aws_access_key_id],
            'secret_access_key' => default[:aws_secret_access_key],
            'balanced_proxy/ssl.crt' => nil,
            'balanced_proxy/ssl.key' => nil
        }
    }
    
    chef.run_list = [
        "recipe[#{default[:project]}]"
    ]
  end

end
