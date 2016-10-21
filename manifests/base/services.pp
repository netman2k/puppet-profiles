# Class: profiles::base::services
#  This class manages content of the /etc/services
#
## Parameters
#    [*securetty*]
#      The content of the /etc/securetty to set
#
## Variables
#
## Authors
#   Daehyung Lee <daehyung@gmail.com>
class profiles::base::services(
  Array $services,
){

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

}
