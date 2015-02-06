# == Class: php::pear
#
# Install PEAR package manager
#
# === Parameters
#
# [*ensure*]
#   The PHP ensure of PHP pear to install
#
# [*package*]
#   The package name for PHP pear
#   For debian it's php5-pear
#
# [*provider*]
#   The provider used to install php5-pear
#   Could be "pecl", "apt" or any other OS package provider
#
# === Variables
#
# No variables
#
# === Examples
#
#  include php::pear
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class softec_php::pear{

  require softec_php
  $php_version = hiera('php_version')

  softec_php::pin {'php-pear':} ->
  class {'php::pear':
    ensure  => $php_version
  }

}
