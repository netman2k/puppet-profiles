# == Class: profiles::ntp
#
# This class manages NTP
#
# === Parameters
#
# [*force_to_use_ntpd*]
#
# [*force_to_use_chrony*]
#
# === Variables
#
# === Authors
#
# Daehyung Lee <daehyung@gmail.com>
#
class profiles::ntp(
  $force_to_use_ntpd    = false,
  $force_to_use_chrony  = false,
  $ntp_servers          = hiera_array('profiles::ntp::servers'),
  $restrict             = hiera_array('profiles::ntp::restrict'),
  $queryhosts           = hiera_array('profiles::ntp::queryhosts'),
  $enable_firewall      = false,
){

  # Decides which daemon should use for time syncing
  if !$::is_virtual and !$force_to_use_ntpd {
    $_load_chrony = true
  } elsif $force_to_use_chrony {
    $_load_chrony = true
  }else{
    $_load_chrony = false
  }


  # Loading time syncing daemon
  if $_load_chrony {

    class { 'profile::ntp::chrony':
      servers    => $ntp_servers,
      queryhosts => $queryhosts,
    }

  }else{

    class { 'profiles::ntp::ntpd':
      servers  => $ntp_servers,
      restrict => $restrict,
    }

  }


  if $::hostgroup == 'ntp_servers' or $enable_firewall{

    # TODO - Firewall settings here
  }
}
