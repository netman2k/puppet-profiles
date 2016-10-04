# == Class: profiles::ntp::ntpd
#
# 
#
# === Parameters
#
# === Variables
#
# === Authors
#
# Daehyung Lee <daehyung@gmail.com>
#
class profiles::ntp::ntpd(
  $servers = [],
  restrict = [],
) {

  include ::ntp::params

  if empty($servers) {
    $_servers = $::ntp::params::servers
  }

  if empty($restrict) {
    $_restrict = $::ntp::params::restrict
  }


  service { 'chronyd': ensure => stopped }

  Service {
    require => Service['chronyd'],
  }


  class { '::ntpd':
    servers  => $_servers,
    restrict => $_restrict,

  }
}

