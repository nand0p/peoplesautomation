node /.*.hex7.com/ {
	include 'nginx'
	file { '/var/www/vhost.hex7.com':
		path => '/var/www/vhost.hex7.com',
		ensure => directory,
		require => Package['nginx'],
	}
	file { '/var/www/vhost.hex7.com/index.html':
		path => '/var/www/vhost.hex7.com/index.html',
		source => 'puppet:///modules/nginx/index.html',
		require => File['/var/www/vhost.hex7.com'],
		ensure => file,
	}
	nginx::resource::vhost { 'vhost.hex7.com':
  		www_root => '/var/www/vhost.hex7.com',
		listen_port => 81,
	} 
   	nginx::resource::location { "/":
     		ensure          => present,
     		ssl             => false,
     		ssl_only        => false,
     		vhost           => "oort.hex7.com",
     		www_root        => "/var/www/vhost.hex7.com",
     		location        => '~ \.php$',
     		index_files     => ['index.php', 'index.html', 'index.htm'],
     		proxy           => undef,
     		fastcgi         => "127.0.0.1:9000",
     		fastcgi_script  => undef,
     		location_cfg_append => {
       			fastcgi_connect_timeout => '3m',
       			fastcgi_read_timeout    => '3m',
       			fastcgi_send_timeout    => '3m'
     		}
   	}
	include php
	file { '/var/www/vhost.hex7.com/index.php':
		path => '/var/www/vhost.hex7.com/index.php',
		source => 'puppet:///modules/nginx/index.php',
		ensure => file,
		require => File['/var/www/vhost.hex7.com'],
	}
}
