class magento {

   file { "/etc/apache2/sites-available/vagrant-magento":
     source => 'puppet:///modules/magento/vhost_magento'
   }

   file { "/etc/apache2/sites-enabled/vagrant-magento":
     ensure => 'link',
     target => '/etc/apache2/sites-available/vagrant-magento'
   }

   file { "/var/log/apache2/magento":
     ensure => 'directory'
   }

   exec { "/usr/sbin/a2enmod rewrite": }
}
