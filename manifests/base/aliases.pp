# Class: profiles::base::aliases
#  This class manages content of the /etc/aliases
#
## Parameters
#    [*aliases*]
#      The content of the /etc/aliases to set
#
#
## Variables
#
## Authors
#   Daehyung Lee <daehyung@gmail.com>
class profiles::base::aliases(
  Hash $aliases,
){

  $default_mailalias = {
    ensure => 'present',
    target => '/etc/aliases',
    notify => Exec['newaliases']
  }

  exec { "newaliases":
    command     => "/usr/bin/newaliases",
    refreshonly => true,
  }

  create_resource(mailalias, $aliases, $default_mailalias)

}
