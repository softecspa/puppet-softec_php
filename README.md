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

If php modules uses the same version of php5-common package. It will follows the same sules specified above. If the module uses a different version it will has its specific hiera variables.
Some module have also an hiera hash that can be used to manage configuration.

### libapache2-mod-php5

include softec\_php::apache

Specific configs can be set only for apache use through and hiera hash. Example:
<pre><code>
php_apache_settings:
    'set PHP/disable_functions': '"phpinfo"'
    'set PHP/error_reporting': '"E_ALL & ~ (E_STRICT | E_NOTICE)"'
    'set PHP/expose_php': 'Off'
</code></pre>

### php5-cli

include softec\_php::cli

Like apache, you can configure specific parameter only for cli through hiera hash

 * php\_cli\_settings:

### apc
include softec\_php::apc

Like php you can specify version and pinning to a specific or major version. You can also manage conf ever by hiera. Examples:

<pre><code>
php_apc_version: "3.1.13-1~%{::lsbdistcodename}+1"
php_apc_major_version: '3'
php_apc_stat_password: 'xxxxxxx'
php_apc_settings:
    'set .anon/apc.enabled': '1'
    'set .anon/apc.mmap_file_mask': '/tmp/apc.XXXXXX'
</code></pre>

### memcache

include softec\_php::memcache

Like apc but with the following parameters:

<pre><code>
php_memcache_version: "3.0.6-5~%{::lsbdistcodename}+1"
php_memcache_major_version: '3'
php_memcache_settings:
    'set memcache/memcache.dbpath': '/var/lib/memcache'
    'set memcache/memcache.maxreclevel': '0'
</code></pre>

### opcache

include softec\_php::opcache

This module is installed throuh pecl. Only version to install can be specified without pinning

<pre><code>
php_opcache_version: '0.7.2'
php_opcache_settings:
    'set .anon/opcache.memory_consumption': '128'
    'set .anon/opcache.interned_strings_buffer': '8'
</code></pre>

### imagick - xdebug - ming - uploadprogress
All this modules have different version from php5-common. Version of this module can be specified like this examples:

include softec\_php::imagick
 * php\_imagick\_version:         "3.1.0~rc2-1~%{::lsbdistcodename}+1"
 * php\_imagick\_major\_version:  '3'

include softec\_php::xdebug
 * php\_xdebug\_version:         "2.2.1-1~%{::lsbdistcodename}+1"
 * php\_xdebug\_major\_version:   '2'

include softec\_php::ming
 * php\_ming\_version:           "1:0.4.4-1.1~%{::lsbdistcodename}+1"
 * php\_ming\_major\_version:     '1'

include softec\_php::uploadprogress (through pecl)
 * php\_uploadprogress\_version: '1.0.3.1'
