# Class: Profiles::ssh
#
## Parameters
#
## Variables
#
## Authors
# Daehyung.lee <daehyung@gmail.com>
#
class profiles::ssh {
  $options = hiera_hash('ssh::server_options')
  $ports = $options['Port']

  # Set SELinux for SSH
  # This will add ports into ssh_port_t context
  include  '::selinux'
  $ports.each |String $port| {
    ::selinux::port { "selinux_ssh_${port}":
      context  => 'ssh_port_t',
      port     => $port,
      protocol => 'tcp',
    }
  }

  include ::ssh

  # TODO
  # Write down Firewall Settings here
}
