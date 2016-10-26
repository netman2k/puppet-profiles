# == Class: Profiles::monitoring::nrpe
#   This class set basic NRPE settings
# === Parameters
#
# === Variables
#
# === Authors
#   Daehyung.lee <daehyung@gmail.com>
class profiles::monitoring::nrpe {

  $nrpe_ports = hiera_array('profiles::monitoring::nrpe::ports', [])

  # Adds service ports into /etc/services
  $nrpe_ports.each |Integer $port|{
    ::etc_services { "nrpe-${port}/tcp":
      port    => String($port, "%d"),
      aliases => [ 'nagios-nrpe', 'nrpe' ],
      comment => 'The Nagios NRPE for CDNetworks',
      tag     => [ 'etc_services' ]
    }
  }
}
