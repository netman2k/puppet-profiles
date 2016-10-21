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
class profiles::base::pam($allowed_users){

    # ghoneycutt/pam has set 'pam_fprintd.so' in the default_pam_auth_lines
    # but we don't need it, that's why I reassign this values as below:
    $pam_auth_lines = [
      'auth        required      pam_env.so',
      'auth        sufficient    pam_unix.so nullok try_first_pass',
      'auth        requisite     pam_succeed_if.so uid >= 1000 quiet_success',
      'auth        required      pam_deny.so',
    ]

    # ghoneycutt/pam has set to be md5 password is sufficient
    # but we don't want it. so I changed it with sha512.
    $pam_password_password_lines = [
      'password    requisite     pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type=',
      'password    sufficient    pam_unix.so sha512 shadow nullok try_first_pass use_authtok',
      'password    required      pam_deny.so',
    ]
    # The below will lookup the values via hiera
    class { '::pam':
      pam_auth_lines              => $pam_auth_lines,
      pam_password_password_lines => $pam_password_password_lines,
      allowed_users               => $allowed_users,
      manage_nsswitch             => false,
    }
}
