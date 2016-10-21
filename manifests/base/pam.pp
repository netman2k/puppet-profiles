# Class: profiles::base::pam
#  This class manages content of the pam related stuff
#  Internally, this class uses the ghoneycutt/pam module.
#  this module set many things via hiera mostly
#  so you need to look at the manual how to set and
#  what's going on when you run it.
#  https://github.com/ghoneycutt/puppet-module-pam
#
#  also this class uses access.conf to user access control
#  you should read man page below before setting
#  https://linux.die.net/man/5/access.conf
#
## Parameters
#    [*allowed_users*]
#     a list of the users who can allow login
#
#
## Variables
#
## Authors
# 	Daehyung Lee <daehyung@gmail.com>
class profiles::base::pam(
  Array $allowed_users,
){

    # The below will lookup the values via hiera
    # Note that I set the pam class not to manage nsswitch
    # If you want to manage nsswitch you should install sssd package first.
    class { '::pam':
      allowed_users   => $allowed_users,
      manage_nsswitch => false,
    }
}
