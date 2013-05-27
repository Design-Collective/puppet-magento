
/**
 * Set Defaults
 */
# set default path for execution
Exec { path => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin' }

package { 'curl':
    ensure => 'present',
}

group { 'puppet':
    ensure => 'present',
}

class { 'apache2':
    document_root => '/vagrant/www',
}

/**
 * MySQL Config
 */
class { 'mysql':
    root_password => 'root',
}

/**
 * Import modules
 */
include apt
include mysql
include apache2
include php5
include composer
include magento
