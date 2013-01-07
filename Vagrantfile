Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  # config.vm.box = "base"
  config.vm.box = "precise32"

  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  # Assign this VM to a host only network IP, allowing you to access it
  # via the IP.
  # config.vm.network :hostonly, "33.33.33.10"
  config.vm.network :hostonly, "192.168.33.10"

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  config.vm.forward_port 80, 8080

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  #config.vm.share_folder "v-data", "/vagrant", "data", { :nfs => true }
  config.vm.share_folder "v-data", "/vagrant", "www", { :nfs => true }
  
  # Set the Timezone to something useful
  config.vm.provision :shell, :inline => "echo \"America/Denver\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"
  # Update the server
  config.vm.provision :shell, :inline => "apt-get update --fix-missing"

  config.vm.provision :puppet do |puppet|
     puppet.pp_path = "/tmp/vagrant-puppet"
     puppet.manifests_path = "puppet/manifests"
     puppet.manifest_file  = "base.pp"
     puppet.module_path    = "puppet/modules"
  end

end
