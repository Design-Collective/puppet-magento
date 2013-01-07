Getting started
---------------
Install software:
    
    download and install `virtualbox` https://www.virtualbox.org/wiki/Downloads
    download & install `vagrant` http://downloads.vagrantup.com/

Create local vagrant dir:

    mkdir ~/Vagrant
    cd ~/Vagrant
    
Get vagrant & puppet Magento setup code:

    git clone https://github.com/jameskleinschnitz/magento-vagrant-puppet.git site_dir
    cd site_dir
    
Run initial vagrant setup:

    vagrant up

Reload vagrant (issue with modules geting executed out of order):

    vagrant reload


Using your magento project
--------------------------

git-clone your magento to `www/magento`, import your mysql database run the query:

    update magento.core_config_data
    set value = 'http://127.0.0.1:8080/'
    where path in ('web/unsecure/base_url', 'web/secure/base_url')

and clear the magento cache (`var/cache/`)

adjust host file on your local machine

FAQ's
-----

If you have networking problems:

    vagrant ssh
    sudo /etc/init.d/networking restart
