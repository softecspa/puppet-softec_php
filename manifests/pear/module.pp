define softec_php::pear::module (
  $ensure   = 'present',
  $package  = '',
) {

  require softec_php::pear

  $package_name = $package? {
    ''      => $name,
    default => $package
  }

  php::extension{$package_name:
    ensure    => $ensure,
    package   => $package_name,
    provider  => 'pear',
  }

}
