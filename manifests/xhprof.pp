# Class: php5::xhprof
#
# Usage:
# include php5::xhprof

class softec_php::xhprof {

  require softec_php
  include ::php
	$tmpdir = "/tmp/xhprof"
	$phpinfo_cli = "echo '<?php phpinfo(); ?>' | php -i"

  git::clone{'xhprof':
    url     => 'https://github.com/facebook/xhprof.git',
    path    => $tmpdir,
  } ->

  exec {'xhprof-installation':
    cwd     => '/tmp/xhprof/extension',
    command => '/usr/bin/phpize && ./configure && /usr/bin/make && /usr/bin/make install',
    unless  => "${phpinfo_cli} | grep '^xhprof$'",
  } ->

  file { "${::php::params::config_root}/conf.d/xhprof.ini":
    ensure  => present,
    mode    => 644,
    owner   => root,
    group   => root,
    source  => "puppet:///modules/softec_php/xhprof.ini",
  }

  exec { "xhprof-apache2-reload":
    command		=> "/etc/init.d/apache2 force-reload",
    subscribe	=> File["${::php::params::config_root}/conf.d/xhprof.ini"],
    refreshonly	=> true,
  }
}
