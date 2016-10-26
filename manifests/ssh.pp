# == Class: Profiles::ssh
#
# === Parameters
#
# === Variables
#
# === Authors
# Daehyung.lee <daehyung@gmail.com>
#
class profiles::ssh {
  $server_options = hiera_hash('ssh::server_options')
  $client_options = hiera_hash('ssh::client_options')
  $ports = $server_options['Port']

  include  '::selinux'

  $ports.each |Variant[Integer,String] $port| {
    # Set SELinux for SSH
    # This will add ports into ssh_port_t context
    ::selinux::port { "selinux_ssh_${port}":
      context  => 'ssh_port_t',
      port     => $port,
      protocol => 'tcp',
      tag      => [ 'selinux_port' ]
    }
    # Adds service ports into /etc/services
    ::etc_services { "ssh-${port}/tcp":
      port    => String($port, "%d"),
      aliases => [ 'ssh', 'kss-ssh' ],
      comment => 'The Secure Shell (SSH) Protocol for CDNetworks',
      tag     => [ 'etc_services' ]
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
