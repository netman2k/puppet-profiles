# Class: Profiles::base::motd
#  This class manages welcome screen which is defined in the /etc/motd
#
## Parameters
#  	[*motd_content*]
#			The content of the /etc/motd to set
#
## Variables
#
## Authors
# 	Daehyung Lee <daehyung@gmail.com>
class profiles::base::motd(
  $motd_content
){

  if empty($motd_content)
    fail('You need to set any content of the motd via hiera or param!')
  }

  file { '/etc/motd':
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => 'root'
    content => $motd_content,
  }

}
