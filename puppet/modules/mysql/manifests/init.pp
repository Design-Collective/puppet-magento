class mysql( $root_pass ) {

    # Install the MySQL server and client
    package { [ "mysql-server", "mysql-client" ]:
        ensure  => installed,
        notify  => Service['apache2'],
        before  => File["/etc/mysql/my.cnf"],
    }

    # Add the MySQL configuration file
    file { "/etc/mysql/my.cnf":
        ensure  => file,
        content => template("mysql/my_cnf.erb"),
    } 

    exec { "Set MySQL server root password":
        subscribe => [ Package["mysql-server"], Package["mysql-client"] ],
        refreshonly => true,
        unless  => "mysqladmin -uroot -p${root_pass} status",
        path    => "/bin:/usr/bin",
        command => "mysqladmin -uroot password ${root_pass}",
        require => Package['mysql-server'],
    }

    exec { "Create vagrant user":
        unless  => "/usr/bin/mysqladmin -uvagrant -pvagrant status",
        command => "/usr/bin/mysql -uroot -p${root_pass} -e \"CREATE USER vagrant@'localhost' IDENTIFIED BY 'vagrant'; Grant all on *.* TO vagrant@'%';\"",
        require => Service["mysql"],
    }

    service { "mysql":
        ensure  => "running",
        require => [ Package["mysql-server"], Exec['Set MySQL server root password'] ],
        subscribe => File["/etc/mysql/my.cnf"],
    }
}
