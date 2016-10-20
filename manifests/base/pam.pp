# Class: profiles::base::pam
#  This class manages content of the pam related stuff
#  Internally, this class uses the ghoneycutt/pam module.
#  this module set many things via hiera mostly
#  so you need to look at the manual how to set and
#  what's going on when you run it.
#  https://github.com/ghoneycutt/puppet-module-pam
#
## Parameters
#
## Variables
#
## Authors
# 	Daehyung Lee <daehyung@gmail.com>
class profiles::base::pam(){

    # The below will lookup the values via hiera
    class { '::pam': }
}
