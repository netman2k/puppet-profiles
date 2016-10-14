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

  include  '::selinux'

  $ports.each |Integer $port| {
    # Set SELinux for SSH
    # This will add ports into ssh_port_t context
    ::selinux::port { "selinux_ssh_${port}":
      context  => 'ssh_port_t',
      port     => $port,
      protocol => 'tcp',
    }
    # Adds service ports into /etc/services
    ::etc_services { "kss-ssh-${port}/tcp":
      port    => $port,
      aliases => [ 'ssh' ],
      comment => 'The Secure Shell (SSH) Protocol for CDNetworks'
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
