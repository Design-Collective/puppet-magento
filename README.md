A **standalone Magento DevOps environment** built with [Vagrant](http://www.vagrantup.com/) and [Puppet](http://puppetlabs.com/) from a vanilla Ubuntu 12.04 LTS box.

Leverage [Composer](http://getcomposer.org/) and [Phing](http://www.phing.info/) scripts for enhanced DevOps automation.

Use your own Magento code or have it install the Magento version of your choice.

## Getting Started

1. Install the required software for your **host** machine
 * Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
 * Download and install [Vagrant](http://downloads.vagrantup.com/)
 * Download and install [Git](http://git-scm.com/downloads)

2. Create the parent directory for your projects
```
mkdir ~/vagrant
cd ~/vagrant
```

3. Grab the magento-vagrant-puppet code
```
git clone https://github.com/matthewsplant/magento-vagrant-puppet.git project_dir
cd project_dir
```

4. (Optional) Have script install Magento
 * Set install to true in the Magento class of the main puppet manifest file (base.pp)
 * Set the Magento version also in the Magento class of the main puppet manifest file
 * And remember to revert the install back to false after install

5. (Optional) Use your own Magento code
 * "git-clone" your Magento project to "www/magento"
 * Import your MySQL database and update the base URLs via the following MySQL query:
```
UPDATE magento.core_config_data
SET value = 'http://magento.localhost:8080/'
WHERE path in ('web/unsecure/base_url', 'web/secure/base_url')
```
 * Clear the Magento cache

6. Add *magento.localhost* to your hosts /etc/hosts file
```
    127.0.0.1       magento.localhost
```

7. **Spin up your new DevOps environment**
```
    vagrant up
```
8. (Optional) Install Phing along with additional support libraries on your new DevOps environment
```
vagrant ssh
cd /vagrant
composer install
```

## Security Note

This virtual machine is optimized for ease of use.  Therefore it is not meant for production use.

## FAQ

#### Credentials (set in the main puppet manifest file)
 * MySQL root/r00t
 * MySQL vagrant/vagrant
 * Magento Admin - admin/123123abc

#### Virtual Machine Specifications
 * Ubuntu 12.04 LTS aka "precise32"
 * Apache 2.2.22
 * MySQL 5.5.31
 * PHP 5.3.10
 * Composer
 * Phing 2.5.0 

See http://magento.localhost:8080/phpinfo.php for more details.

#### Why didn't you put the "puppet" directory in the vendor directory?
 * It was this way
 * I like having the host vm separate from the client "vendor" files
 * It makes it easy to exclude the whole client "vendor" directory from git
