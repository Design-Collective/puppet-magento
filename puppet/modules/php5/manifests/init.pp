class php5 {

   # Install PHP5 and trigger Apache reload
   package { [ 'php5-cli', 'php5-common', 'php5-mysql', 'php5-curl', 'php5-gd', 'php5-intl', 'php5-mcrypt', 'libapache2-mod-php5' ]:
 	    ensure  => installed,
 	    require => [ Package['mysql-client'], Package['apache2'] ],
 	    notify  => Service['apache2'],
   }
}
