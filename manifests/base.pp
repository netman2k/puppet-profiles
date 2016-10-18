# Class: Profiles::base
#
## Parameters
#
## Variables
#
## Authors
#  Daehyung Lee <daehyung@gmail.com>
class profiles::base {

  $motd_content =  hiera('profiles::base::motd')
  $login_defs_options = hiera_hash('profiles::base::login_defs::options')
  $services = hiera_array('profiles::base::services')
  $securetty = hiera_array('profiles::base::securetty')
  $profile_d = hiera_hash('profiles::base::etc_profile_d')

  $_ttys = empty($securetty) ? {
    false   => $securetty,
    default => [ 'console' ]
  }

  file { '/etc/motd':
    ensure  => file,
    content => $motd_content,
  }

  class { '::login_defs':
    options => $login_defs_options,
  }

  # Adds service ports into /etc/services
  $services.each | Hash $svc | {
    $_name = $svc['name']
    $_protocol = $svc['protocol']
    $_port = String($svc['port'], "%d")
    $_aliases = empty($svc['aliases']) ? {
      true  => [],
      false => $svc['aliases']
    }
    $_comment = $svc['comment']
    ::etc_services { "${_name}/${_protocol}":
      port    => $_port,
      aliases => $_aliases,
      comment => $_comment,
      tag     => [ 'etc_services' ]
    }
  }

  # Set tty on /etc/securetty
  file { '/etc/securetty':
    ensure  => file,
    mode    => '0400',
    content => $_ttys,
  }

  # The below will lookup limits::entries key from hiera
  class { '::limits': }

  $profile_default = {
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => 'root'
  }
  # Set environment variables in the /etc/profile.d
  create_resources(file, $profile_d, $profile_default)

}
