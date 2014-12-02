class softec_php::ming {

  require softec_php

  #TODO: capire se serve pushare il template
  $ming_settings = [
    'set .anon/extension' => 'ming.so',
  ]

  $php_ming_version       = hiera('php_ming_version')
  $php_ming_major_version = hiera('php_ming_major_version')

  softec_php::pin { 'php5-ming':
    version       => $php_ming_version,
    major_version => $php_ming_major_version
  } ->

  #TODO: attualmente l'ini file è in /etc/php5/conf.d/ming.ini
  php::extension{'ming':
    ensure    => $php_ming_version,
    package   => 'php5-ming'
  }
}
