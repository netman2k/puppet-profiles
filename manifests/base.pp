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

  file { '/etc/motd':
    ensure  => file,
    content => $motd_content,
  }

  class { '::login_defs':
    options => $login_defs_options,
  }

  
}
