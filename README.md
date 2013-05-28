Summary
-------

A standalone Magento DevOps environment built with Vagrant and Puppet from a vanilla Ubuntu 12.04 LTS box.

Leverage Composer and Phing scripts for enhanced DevOps automation.

Use your own Magento code or have it install the Magento CE version of your choice.


Getting started
---------------

Install the required software for your host machine:
    Download and install VirtualBox from https://www.virtualbox.org/wiki/Downloads
    Download and install Vagrant from http://downloads.vagrantup.com/

Create the parent directory for your projects:
    mkdir ~/Vagrant
    cd ~/Vagrant
    
Grab the magento-vagrant-puppet project:
    git clone https://github.com/matthewsplant/magento-vagrant-puppet.git project_dir
    cd project_dir
    
Decide if you want to install a Magento CE version or use your own
    If you want to install latest Magento CE:
        Set install to true in the Magento class of the main puppet manifest file (base.pp)
        Set the Magento version also in the Magento class of the main puppet manifest file
        And remember to revert back to false after install :)
    If you want to use your own Magento Project:
        See notes below

Add the magento.localhost to your local hosts /etc/hosts file:
    127.0.0.1       magento.localhost

Run initial vagrant setup:
    vagrant up



Using your own Magento project
------------------------------

"git-clone" your Magento project to "www/magento"

Import your MySQL database and update the base URLs via the following MySQL query:
    UPDATE magento.core_config_data
    SET value = 'http://magento.localhost:8080/'
    WHERE path in ('web/unsecure/base_url', 'web/secure/base_url')

Clear the Magento cache



FAQ's
-----

Credentials (set in the main puppet manifest file)
 * MySQL root/r00t
 * MySQL vagrant/vagrant
 * Magento Admin - admin/123123abc

Virtual Machine Specifications
 * Ubuntu 12.04 LTS aka "precise32"
 * Apache 2.2.22
 * MySQL 5.5.31
 * PHP 5.3.10
 * Composer b38db7361189acff3384ddba9d4f2afba610fb78 (is there an alternative number?)
 * Phing 2.5.0

Why didn't you put the "puppet" directory in the vendor directory?
  1) It was this way
  2) I like having the host vm separate from the client "vendor" files
  3) It makes it easy to exclude the whole client "vendor" directory from git
