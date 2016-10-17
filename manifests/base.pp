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
    }
  }

}
