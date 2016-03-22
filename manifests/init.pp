# Wrapper of PHP module
class softec_php {

  if $::operatingsystem != 'Ubuntu' {
    fail("Recipes works only on Ubuntu, your are using ${::operatingsystem}")
  }


  include ::php

  $php_version  = hiera('php_version')
  $manage_repo  = hiera('php_manage_repo')

  if $manage_repo {
    $php_ppa      = hiera('php_ppa')
    $php_ppa_key  = hiera('php_ppa_key')
    $mirror       = $::lsbdistcodename ? {
      /hardy|lucid/ => true,
      default       => false,
    }

    softec_apt::ppa { $php_ppa:
      mirror => $mirror,
      key    => $php_ppa_key,
      before => Softec_php::Pin['php5-common']
    }

  }

  include php::composer
  include php::composer::auto_update

  softec_php::pin {'php5-common':} ->

  php::contrib::base_package{'php5-common':
    ensure  => $php_version
  }

  if defined(Class['apache']) {
    # Install extensions
    Php::Extension <| |>
    # Configure extensions
    -> Php::Config <| |>
    # Reload webserver
    ~> Service['httpd']
  } else {
    # Install extensions
    Php::Extension <| |>
    # Configure extensions
    -> Php::Config <| |>
  }
}
