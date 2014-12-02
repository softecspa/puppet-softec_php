define softec_php::extension (
  $package      = '',
){

  require softec_php
  $php_version = hiera('php_version')

  $packagename = $package? {
    ''      => "php5-${name}",
    default => $package
  }

  softec_php::pin {$packagename:} ->

  php::extension{$packagename:
    ensure  => $php_version,
    package => $packagename
  }

}
