class composer {
    exec { 'Install Composer':
        command => 'curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer',
        require => [ Package['curl'], Package['php5-cli'] ],
    }
}
