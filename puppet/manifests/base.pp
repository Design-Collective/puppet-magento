group { "puppet":
    ensure => "present",
}

class { "apache2":
    document_root => "/vagrant",
}

/**
 * MySQL Config
 */
class { "mysql":
    root_password => "root",
}

/**
 * Import modules
 */
include apt
include mysql
include apache2
include php5
include magento
