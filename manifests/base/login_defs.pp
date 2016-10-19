# Class: profiles::base::login_defs
#  This class manages content of the /etc/login.defs
#
## Parameters
#  	[*login_defs_options*]
#			The content of the /etc/login.defs to set
#
## Variables
#
## Authors
# 	Daehyung Lee <daehyung@gmail.com>
class profiles::base::login_defs(
  $login_defs_options
){
  if ! empty($login_defs_options){
    class { '::login_defs':
      options => $login_defs_options,
    }
  }

}
