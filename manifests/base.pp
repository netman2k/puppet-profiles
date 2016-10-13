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

  file { '/etc/motd':
    ensure  => file,
    content => $motd_content,
  }

  class { '::login_defs':

  }
}
