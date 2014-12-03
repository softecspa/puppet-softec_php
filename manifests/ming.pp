class softec_php::ming {

  require softec_php

  $php_ming_version       = hiera('php_ming_version')
  $php_ming_major_version = hiera('php_ming_major_version')

  softec_php::pin { 'php5-ming':
    version       => $php_ming_version,
    major_version => $php_ming_major_version
  } ->

  php::extension{'ming':
    ensure    => $php_ming_version,
    package   => 'php5-ming'
  }
}
