class softec_php::xdebug {

  require softec_php
  $php_xdebug_version       = hiera('php_xdebug_version')
  $php_xdebug_major_version = hiera('php_xdebug_major_version')

  softec_php::pin { 'php5-xdebug':
    version       => $php_xdebug_version,
    major_version => $php_xdebug_major_version
  } ->

  php::extension{'xdebug':
    ensure    => $php_xdebug_version,
    package   => 'php5-xdebug'
  }
}
