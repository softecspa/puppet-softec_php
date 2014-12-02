define softec_php::module {

  require softec_php
  $php_version = hiera('php_version')
  $php_class_name = "php::extension::${name}"

  softec_php::pin { "php5-${name}":} ->

  class {$php_class_name:
    ensure  => $php_version
  }

}
