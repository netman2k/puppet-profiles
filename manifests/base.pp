# Class: Profiles::base
#
## Parameters
#
## Variables
#
## Authors
#  Daehyung Lee <daehyung@gmail.com>
class profiles::base {

  $login_defs_options = hiera_hash('profiles::base::login_defs::options')
  $securetty = hiera_array('profiles::base::securetty')
  $motd_content = hiera('profiles::base::motd')
  $services = hiera_array('profiles::base::services')
  $env_hash = hiera_hash('profiles::base::environment::env_hash')
  $allowed_users = hiera_array('profiles::base::pam::allowed_users')
  $pam_auth_lines = hiera_array('profiles::base::pam::pam_auth_lines')

  $aliases = hiera_hash('profiles::base::aliases::aliases')

  class { '::profiles::base::login_defs':
    login_defs_options => $login_defs_options,
  }

  class { '::profiles::base::motd':
    motd_content => $motd_content,
  }

  class { '::profiles::base::securetty':
    securetty => $securetty,
  }

  class { '::profiles::base::services':
    services => $services,
  }

  class { '::profiles::base::environment':
    env_hash => $env_hash,
  }

  class { '::profiles::base::pam':
    allowed_users  => $allowed_users,
    pam_auth_lines => $pam_auth_lines,
  }

  class { '::profiles::base::aliases':
    aliases => $aliases,
  }

  class { '::selinux': }


}
