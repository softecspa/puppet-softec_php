puppet-softec\_php
=================

This module is a wrapper of puppetlabs-php module. Based on parameters stored on hiera it:

 * add ppa repository for php5.4 on ubuntu lucid and precise
 * pin all php packages to a specified version (if a specific php version is installed)
 * pin all php mackages to a major version (if php version is set to latest)
 * manage configuration for php packages

## Manage php installation and version

### Use a PPA
Define in hiera following parameters:

 * php\_manage\_repo: true|false
 * php\_ppa: (ignored id php\_manage\_repo is false)
 * php\_ppa\_key: (ignored id php\_manage\_repo is false)

### Specify php version
Define in hiera following parameters:

 * php\_version: latest|specific\_version

if php\_version is set to a specific version you can pin that specific version through:

 * php\_pin: true

If php\_version is set to latest you can specify php\_major\_version and all php packages will be pinned on this major version. Example

 * php\_major\_version: '3.4'

## PHP modules

### libapache2-mod-php5

include softec\_php::apache

Specific configs can be set only for apache use through and hiera hash. Example:
<pre><code>
php_apache_settings:
    'set .anon/disable_functions': '"phpinfo"'
    'set .anon/error_reporting': '"E_ALL & ~ (E_STRICT | E_NOTICE)"'
    'set .anon/expose_php': 'Off'
</code></pre>

### php5-cli

include softec\_php::cli

Like apache, you can configure specific parameter only for cli through hiera hash

 * php\_cli\_settings:

### apc
include softec\_php::apc

Like php version you can specify version and pinning to a specific or major version. You can also manage conf ever by hiera. Examples:

<pre><code>
php_apc_version: "3.1.13-1~%{::lsbdistcodename}+1"
php_apc_major_version: '3'
php_apc_stat_password: 'xxxxxxx'
php_apc_settings:
    'set .anon/apc.enabled': '1'
    'set .anon/apc.mmap_file_mask': '/tmp/apc.XXXXXX'
</code></pre>


