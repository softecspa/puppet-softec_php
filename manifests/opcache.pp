class softec_php::opcache {

  require softec_php
  require softec_php::pear
  include ::php::params
  $php_opcache_version  = hiera('php_opcache_version')
  $php_opcache_settings = hiera_hash('php_opcache_settings',undef)
  $array_php_opcache_settings = $php_opcache_settings? {
    undef   => undef,
    default => php_hash2array($php_opcache_settings)
  }

  include softec_php::pear

  class {'php::extension::opcache':
    ensure    => $php_opcache_version,
    provider  => 'pecl',
    package   => 'zendopcache',
    settings  => $array_php_opcache_settings,
  } ->

  file {'/etc/php5/conf.d/10-zendopcache.ini':
    ensure  => link,
    target  => "${::php::params::config_root_ini}/opcache.ini"
  }
}
