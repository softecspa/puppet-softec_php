class softec_php::varnish {

  require softec_php
  require softec_php::pear
  include ::php::params
  $php_varnish_version = hiera('php_varnish_version',undef)

  $ensure = $php_varnish_version?{
    undef   => present,
    default => $php_varnish_version
  }

  php::extension {'varnish':
    ensure    => $ensure,
    provider  => 'pecl',
    package   => 'varnish',
    require   => Package['libvarnishapi-dev']
  } ->

  file {"${::php::params::config_root_ini}/varnish.ini":
    ensure  => present,
    mode    => 644,
    owner   => 'root',
    group   => 'root',
    content => ";GENERATED WITH PUPPET\nextension=varnish.so",
  } ->

  file {'/etc/php5/conf.d/varnish.ini':
    ensure  => link,
    target  => "${::php::params::config_root_ini}/varnish.ini",
  }

}
