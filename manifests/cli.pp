class softec_php::cli {

  require softec_php

  $php_version = hiera('php_version')
  $php_cli_settings = hiera_hash('php_cli_seggings',undef)

  $array_php_cli_settings = $php_cli_settings?{
    undef => undef,
    default => php_hash2array($php_cli_settings)
  }

  softec_php::pin {'php5-cli':} ->
  include php::cli
  #class{'php::cli':
  #  ensure    => $php_version,
  #  settings  => $array_php_cli_settings
  #}
}
