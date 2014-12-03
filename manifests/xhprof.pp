# Class: php5::xhprof
#
# Usage:
# include php5::xhprof

class softec_php::xhprof {

  require softec_php
  include ::php::params

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
    notify  => Exec['apache2-graceful']
  }
}
