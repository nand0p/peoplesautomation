class peoples::automation {
	Package { "epel-release: Ensure => "installed" }
	Package { "nginx: Ensure => "installed", Require => Package["epel-release"] }
	File { "/usr/share/nginx/html/index.html": Source  => "puppet:///modules/peoples/index.html", Require => Package["nginx"] }
        Service { "nginx": Ensure => running, Require => Package["nginx"] }
}
