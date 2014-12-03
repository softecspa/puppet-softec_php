class softec_php::apache {

  require softec_php
  $php_version = hiera('php_version')
  $php_apache_settings = hiera_hash('php_apache_settings',undef)
  $array_php_apache_settings = $php_apache_settings?{
    undef   => undef,
    default => php_hash2array($php_apache_settings),
  }

  softec_php::pin {'libapache2-mod-php5':} ->

  class {'php::apache':
    ensure    => $php_version,
    settings  => $array_php_apache_settings
  }
}
