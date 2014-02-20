# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  # config.vm.box = "base"
  config.vm.box = "precise32"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  # config.vm.box_url = "http://domain.com/path/to/above.box"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"


  # NETWORK CONFIGS

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network :forwarded_port, guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network :private_network, ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder ".", "/vagrant" # DEFAULT
  config.vm.synced_folder ".", "/vagrant", :mount_options => ["dmode=777,fmode=777"] # VirtualBox shared directory workaround

  # Set the virtual machine host name
  config.vm.hostname = "magento.localhost"


  # ADDITIONAL CONFIGURATIONS

  # Set the timezone
  config.vm.provision :shell, :inline => "echo \"EST\" |
    sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"


  # PROVIDER CONFIGS

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # View the documentation for the provider you're using for more
  # information on available options.

  # VirtualBox

  # Use VBoxManage to customize the VM
  config.vm.provider :virtualbox do |vb|
    # Boot with a GUI so you can see the screen. (Default is headless)
    # vb.gui = true

    # set virtual machine name
    vb.name = "magento-devops"

    # increase virtual machine memory
    #vb.customize ["modifyvm", :id, "--memory", "1024"]
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    #vb.customize ["modifyvm", :id, "--memory", "4096"]
    #vb.customize ["modifyvm", :id, "--memory", "9192"]
  end


  # PUPPET CONFIGS

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest file
  # in the manifests_path directory.
  config.vm.provision :puppet do |puppet|
  #  puppet.pp_path = "/tmp/vagrant-puppet"
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "base.pp"
    puppet.module_path    = "puppet/modules"
    puppet.options = "--verbose --debug"
  end


  # CHEF SOLO

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  # config.vm.provision :chef_solo do |chef|
  #   chef.cookbooks_path = "../my-recipes/cookbooks"
  #   chef.roles_path = "../my-recipes/roles"
  #   chef.data_bags_path = "../my-recipes/data_bags"
  #   chef.add_recipe "mysql"
  #   chef.add_role "web"
  #
  #   # You may also specify custom JSON attributes:
  #   chef.json = { :mysql_password => "foo" }
  # end

  # Enable provisioning with chef server, specifying the chef server URL,
  # and the path to the validation key (relative to this Vagrantfile).
  #
  # The Opscode Platform uses HTTPS. Substitute your organization for
  # ORGNAME in the URL and validation key.
  #
  # If you have your own Chef Server, use the appropriate URL, which may be
  # HTTP instead of HTTPS depending on your configuration. Also change the
  # validation key to validation.pem.
  #
  # config.vm.provision :chef_client do |chef|
  #   chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
  #   chef.validation_key_path = "ORGNAME-validator.pem"
  # end
  #
  # If you're using the Opscode platform, your validator client is
  # ORGNAME-validator, replacing ORGNAME with your organization name.
  #
  # If you have your own Chef Server, the default validation client name is
  # chef-validator, unless you changed the configuration.
  #
  #   chef.validation_client_name = "ORGNAME-validator"

end
