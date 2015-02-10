class peoples::automation {
	package { "epel-release: ensure => "installed" }
	package { "nginx: ensure => "installed", Require => Package["epel-release"] }
	file { "/usr/share/nginx/html/index.html": source  => "puppet:///modules/peoples/index.html", Require => Package["nginx"] }
        service { "nginx": ensure => running, Require => Package["nginx"] }
}
