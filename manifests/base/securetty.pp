# Class: profiles::base::securetty
#  This class manages content of the /etc/securetty
#
## Parameters
#  	[*securetty*]
#			The content of the /etc/securetty to set
#
## Variables
#
## Authors
# 	Daehyung Lee <daehyung@gmail.com>
class profiles::base::securetty(
  $securetty = 'console',
){

  # Set tty on /etc/securetty
  file { '/etc/securetty':
    ensure  => file,
    mode    => '0400',
    owner   => 'root',
    group   => 'root'
    content => $securetty,
  }
}
