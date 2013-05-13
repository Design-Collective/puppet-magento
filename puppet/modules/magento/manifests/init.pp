class magento {

    file { "/etc/apache2/sites-available/vagrant-magento":
        source => '/vagrant/puppet/modules/magento/files/vhost_magento',
        require => Package["apache2"],
        notify  => Service["apache2"],
    }

    file { "/etc/apache2/sites-enabled/vagrant-magento":
        ensure => 'link',
        target => '/etc/apache2/sites-available/vagrant-magento',
        require => Package["apache2"],
        notify  => Service["apache2"],
    }

    exec { "/usr/sbin/a2enmod rewrite": }
}
