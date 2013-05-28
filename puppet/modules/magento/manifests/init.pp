class magento( $install, $db_user, $db_pass, $version, $admin_user, $admin_pass, $use_rewrites) {

    if $install {

        exec { "create-magentodb-db":
            unless  => "/usr/bin/mysql -uroot -p${mysql::root_pass} magentodb",
            command => "/usr/bin/mysqladmin -uroot -p${$mysql::root_pass} create magentodb",
            require => Service["mysql"],
        }

        exec { "grant-magentodb-db-all":
            unless  => "/usr/bin/mysql -u${db_user} -p${db_pass} magentodb",
            command => "/usr/bin/mysql -uroot -p${$mysql::root_pass} -e \"grant all on *.* to magento@'%' identified by '${db_pass}' WITH GRANT OPTION;\"",
            require => [ Service["mysql"], Exec["create-magentodb-db"] ],
        }

        exec { "grant-magentodb-db-localhost":
            unless  => "/usr/bin/mysql -u${db_user} -p${db_pass} magentodb",
            command => "/usr/bin/mysql -uroot -p${$mysql::root_pass} -e \"grant all on *.* to magento@'localhost' identified by '${db_pass}' WITH GRANT OPTION;\"",
            require => Exec["grant-magentodb-db-all"],
        }

        exec { "download-magento":
            cwd     => "/tmp",
            command => "/usr/bin/wget http://www.magentocommerce.com/downloads/assets/${version}/magento-${version}.tar.gz",
            creates => "/tmp/magento-${version}.tar.gz",
        }

        exec { "untar-magento":
            cwd     => $apache2::document_root,
            command => "/bin/tar xvzf /tmp/magento-${version}.tar.gz",
            timeout => 600,
            require => Exec["download-magento"],
        }

        exec { "setting-permissions":
            cwd     => "${apache2::document_root}/magento",
            command => "/bin/chmod 550 mage; /bin/chmod o+w var var/.htaccess app/etc; /bin/chmod -R o+w media",
            require => Exec["untar-magento"],
        }

        host { 'magento.localhost':
            ip      => '127.0.0.1',
        }

        exec { "install-magento":
            cwd     => "${apache2::document_root}/magento",
            creates => "${apache2::document_root}/magento/app/etc/local.xml",
            command => "/usr/bin/php -f install.php -- \
                --license_agreement_accepted \"yes\" \
                --locale \"en_US\" \
                --timezone \"America/Los_Angeles\" \
                --default_currency \"USD\" \
                --db_host \"localhost\" \
                --db_name \"magentodb\" \
                --db_user \"${db_user}\" \
                --db_pass \"${db_pass}\" \
                --url \"http://magento.localhost:8080/magento\" \
                --use_rewrites \"${use_rewrites}\" \
                --use_secure \"no\" \
                --secure_base_url \"http://magento.localhost:8080/magento\" \
                --use_secure_admin \"no\" \
                --skip_url_validation \"yes\" \
                --admin_firstname \"Store\" \
                --admin_lastname \"Owner\" \
                --admin_email \"magento@example.com\" \
                --admin_username \"${admin_user}\" \
                --admin_password \"${admin_pass}\"",
            require => [ Exec["setting-permissions"], Exec["create-magentodb-db"], Package["php5-cli"] ],
        }

        exec { "register-magento-channel":
            cwd     => "${apache2::document_root}/magento",
            onlyif  => "/usr/bin/test `${apache2::document_root}/magento/mage list-channels | wc -l` -lt 2",
            command => "${apache2::document_root}/magento/mage mage-setup",
            require => Exec["install-magento"],
        }
    }

    file { "/etc/apache2/sites-available/magento":
        source  => '/vagrant/puppet/modules/magento/files/vhost_magento',
        require => Package["apache2"],
        notify  => Service["apache2"],
    }

    file { "/etc/apache2/sites-enabled/magento":
        ensure  => 'link',
        target  => '/etc/apache2/sites-available/magento',
        require => Package["apache2"],
        notify  => Service["apache2"],
    }

    exec { "sudo a2enmod rewrite":
        require => Package["apache2"],
        notify  => Service["apache2"],
    }
}
