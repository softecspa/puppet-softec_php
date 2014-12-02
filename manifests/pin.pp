define softec_php::pin (
  $php_pin        = hiera('php_pin'),
  $version        = hiera('php_version'),
  $major_version  = undef,
  $package        = undef,
  $priority       = '1001'
){

  $package_name = $package?{
    undef   => $name,
    default => $package
  }

  if $php_pin {

    if $version == 'latest' or $version == 'present' {
      fail("Cannot pin ${package_name} to ${version}")
    }

    apt::pin { $package_name:
      packages  => $package_name,
      version   => $version,
      priority  => $priority,
    }
  }
  else {

    if $version == 'latest' {

      $php_major_version = $major_version?{
        undef   => hiera('php_major_version'),
        default => $major_version
      }

      apt::pin { $package_name:
        packages  => $package_name,
        version   => "${php_major_version}*",
        priority  => $priority+1
      }
    }

  }
}
