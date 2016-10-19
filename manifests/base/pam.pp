# Class: profiles::base::pam
#  This class manages content of the pam related stuff
#
## Parameters
#
## Variables
#
## Authors
# 	Daehyung Lee <daehyung@gmail.com>
class profiles::base::pam(){


    # The below will lookup the values via hiera
    # https://github.com/ghoneycutt/puppet-module-pam
    class { '::pam': }
}
