class softec_php::uploadprogress {

  require softec_php::pear
  $php_uploadprogress_version = hiera('php_uploadprogress_version')

  php::extension {'uploadprogress':
    ensure    => $php_uploadprogress_version,
    provider  => 'pecl',
    package   => 'uploadprogress',
  }

  if $::lsbdistcodename != 'hardy' {
    file { "/etc/php5/conf.d/uploadprogress.ini":
      ensure  => present,
      owner   => root,
      group   => root,
      mode    => 644,
      source  => "puppet:///modules/softec_php/uploadprogress.ini",
      notify  => Service['apache2'],
      require => Php::Extension['uploadprogress'],
    }
  }
}
