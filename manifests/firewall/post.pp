# == Class: profiles::firewall::post
#
#
# === Parameters
#
# === Variables
#
# === Authors
# Daehyung Lee <daehyung@gmail.com>
#
class profiles::firewall::post {
  firewall { '999 drop all':
    proto  => 'all',
    action => 'drop',
    before => undef,
  }
}

