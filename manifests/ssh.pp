# Class: Profiles::ssh
#
## Parameters
#
## Variables
#
## Authors
# Daehyung.lee <daehyung@gmail.com>
#
class profiles::ssh(

){
  $options = hiera_hash('ssh::server_options')
  $ports = $options['Port']

  $ports.each |String $port| {
    ::selinux::port { "selinux_ssh_${port}":
      context  => 'ssh_port',
      port     => $port,
      protocol => 'tcp',
    }
  }
  contain 'selinux::port'
  include ::ssh

}
