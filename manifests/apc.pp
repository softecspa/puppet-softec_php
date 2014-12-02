class softec_php::apc (
  $user           = 'softec',
  $apcdocroot     = '',
  $pin            = true,
  $enabled        = 1,
  $apc_stat       = 1,
  $shm_size       = '1024M',
  $num_files_hint = '5000',
  $ttl            = '3600',
  $rfc1867        = 1,
  $gc_ttl         = '3600',
  $user_ttl       = '0',
) {

  require softec_php

  $php_apc_version        = hiera('php_apc_version')
  $php_apc_major_version  = hiera('php_apc_major_version')
  $php_apc_settings       = hiera_hash('php_apc_settings',undef)
  $password               = hiera('php_apc_stat_password')

  $array_php_apc_settings = $php_apc_settings?{
    undef   => undef,
    default => php_hash2array($php_apc_settings)
  }

  softec_php::pin{'php-apc':
    version       => $php_apc_version,
    major_version => $php_apc_major_version
  } ->

  class {'php::extension::apc':
    ensure    => $php_apc_version,
    settings  => $array_php_apc_settings
  }

  if $apcdocroot != '' {

    file { "${apcdocroot}/apc.php":
      ensure  => present,
      mode    => '0644',
      source  => 'puppet:///modules/softec_php/apc.php',
      owner   => 'www-data',
      group   => 'www-data',
      require => Class['php::extension::apc']
    }

    file { "${apcdocroot}/apc.conf.php":
      ensure  => present,
      mode    => '0644',
      content => template('softec_php/apc.conf.php.erb'),
      owner   => 'www-data',
      group   => 'www-data',
      require => Class['php::extension::apc']
    }
  }

}
