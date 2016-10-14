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
  $server_options = hiera_hash('ssh::server_options')
  $client_options = hiera_hash('ssh::client_options')
  $ports = $server_options['Port']

  # Set SELinux for SSH
  # This will add ports into ssh_port_t context
  include  '::selinux'
  $ports.each |Integer $port| {
    ::selinux::port { "selinux_ssh_${port}":
      context  => 'ssh_port_t',
      port     => $port,
      protocol => 'tcp',
    }
  }

  class { ::ssh :
    validate_sshd_file => true,
    server_options     => $server_options,
    client_options     => $client_options,
  }


  # TODO
  # Write down Firewall Settings here
}
