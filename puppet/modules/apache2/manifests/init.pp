class apache2( $document_root ) {

    file { "/etc/apache2/sites-available/default":
        content => template("apache2/vhost_default.erb")
    }

    exec { "apt-get update":
        path => "/usr/bin",
    }

    package { "apache2":
        ensure  => present,
        require => Exec["apt-get update"],
    }

    service { "apache2":
        ensure  => "running",
        hasstatus => true,
        hasrestart => true,
        require => Package["apache2"],
    }
}
