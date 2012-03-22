class magento {

   file { "/etc/apache2/sites-available/magento":
     source => 'puppet:///modules/magento/vhost_magento'
   }

   file { "/var/log/apache2/magento":
     ensure => 'directory'
   }
}
