class softec_php::memcache {

  require softec_php

  $php_memcache_version       = hiera('php_memcache_version')
  $php_memcache_major_version = hiera('php_memcache_major_version')
  $php_memcache_settings      = hiera_hash('php_memcache_settings',undef)

  $array_php_memcache_settings = $php_memcache_settings? {
    undef   => undef,
    default => php_hash2array($php_memcache_settings)
  }

  softec_php::pin { 'php5-memcache':
    version       => $php_memcache_version,
    major_version => $php_memcache_major_version
  } ->

  class {'php::extension::memcache':
    ensure    => $php_memcache_version,
    settings  => $array_php_memcache_settings
  } ->

  #TODO: capire se serve
  file {'/etc/apache2/conf.d/php-sessions-memcache':
    ensure  => absent,
    owner   => 'root',
    group   => 'root',
    mode    => '644',
    source  => "puppet:///modules/softec_php/php-sessions-memcache",
    require => Package['apache2']
  } ->

  file { "/var/lib/memcache":
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }

}
