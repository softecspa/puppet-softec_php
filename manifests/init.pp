class softec_php {

  $php_version  = hiera('php_version')
  $manage_repo  = hiera('php_manage_repo')

  if $manage_repo {
    $php_ppa      = hiera('php_ppa')
    $php_ppa_key  = hiera('php_ppa_key')
    $mirror       = hiera('apt_mirror')

    softec_apt::ppa { $php_ppa:
      mirror  => $mirror,
      key     => $php_ppa_key,
      before  => Softec_php::Pin['php5-common']
    }

  }

  softec_php::pin {'php5-common':} ->

  php::contrib::base_package{'php5-common':
    ensure  => $php_version
  }

  #TODO: da eliminare, serve solo ad eliminare il file pushato precedentemente

  file{'/etc/php5/conf.d/php-softec.ini':
    ensure  => absent
  }

  # Install extensions
  Php::Extension <| |>
  # Configure extensions
  -> Php::Config <| |>
  # Reload webserver
  ~> Exec['apache2-graceful']

}
