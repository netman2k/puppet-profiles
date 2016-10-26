# == Class: profiles::base::securetty
#  This class manages content of the /etc/securetty
#
# === Parameters
#    [*securetty*]
#      The content of the /etc/securetty to set
#
# === Variables
#
# === Authors
#   Daehyung Lee <daehyung@gmail.com>
class profiles::base::securetty(
  Array $securetty,
){

  # Set tty on /etc/securetty
  file { '/etc/securetty':
    ensure  => file,
    mode    => '0400',
    owner   => 'root',
    group   => 'root',
    content => join($securetty, '\n'),
  }
}
