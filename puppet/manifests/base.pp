/**
 * Set defaults
 */
# set default path for execution
Exec { path => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin' }

/**
 * Run "apt-get update" before installing packages
 */
exec { 'apt-update':
    command => '/usr/bin/apt-get update'
}

file { "/srv/www/magento":
    ensure => "directory",
}

Exec['apt-update'] -> Package <| |>

package { 'curl':
    ensure => 'present',
}

group { 'puppet':
    ensure => 'present',
}

class { 'apache2':
    document_root => '/srv/www/magento',
}

/**
 * MySQL config
 */
class { 'mysql':
    root_pass => 'r00t',
}

/**
 * Magento config
 */
class { 'magento':
    /* install magento data [true|false] */
    install_magento_seed =>  true,
    sample_data_version => '1.6.1.0',

    /* install magento [true|false] */
    install =>  true,
    /* magento version */
    version     => '1.8.1.0',
    #version    => '1.7.0.2',
    #version    => '1.7.0.1',
    #version    => '1.7.0.0',
    #version    => '1.6.2.0',
    #version    => '1.6.1.0',
    #version    => '1.6.0.0',
    #version    => '1.5.1.0',
    #version    => '1.5.0.1',

    /* magento database settings */
    db_user     => 'magento',
    db_pass     => 'magento',

    /* magento admin user */
    admin_email  => 'magento@designcollective.io',
    admin_user  => 'admin',
    admin_pass  => '123123abcde',

    /* use rewrites [yes|no] */
    use_rewrites => 'no',
    /* Your Domain URL */
    mage_url => 'http://magento.localhost',
    mage_secure_url => 'http://magento.localhost',
}

/**
* Redis config with default info
*/
class { 'redis': }

/**
* PHPMyAdmin config with default info
*/
#class { phpmyadmin:
#    enabled          => 'true'
#    # ip_access_ranges => [ '192.168.1.0/24', '10.30.1.1' ],
#}



/**
 * Import modules
 */
include apt
include mysql
include apache2
include php5
include composer
include magento
include redis
#include phpmyadmin
