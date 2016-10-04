# == Class: profiles::ntp::chrony
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
class profiles::ntp::chrony(
  $servers = [],
  $queryhosts = [],
){

  if empty($servers) {
    fail('You need to assign at least one server in the servers parameter')
  }

  class { '::chrony':
    servers    => $servers,
    queryhosts => $queryhosts
  }

}
