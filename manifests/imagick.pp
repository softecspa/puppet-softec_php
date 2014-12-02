class softec_php::imagick {

  require softec_php
  $php_imagick_version       = hiera('php_imagick_version')
  $php_imagick_major_version = hiera('php_imagick_major_version')

  softec_php::pin { 'php5-imagick':
    version       => $php_imagick_version,
    major_version => $php_imagick_major_version
  } ->

  class {'php::extension::imagick':
    ensure    => $php_imagick_version,
  }

}
