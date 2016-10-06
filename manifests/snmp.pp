# Class: profiles::snmp
# This class set the default configuration on snmpd.conf
#
## Parameters
#
# [*ro_community]
#   Read-only (RO) community string or array for snmptrap daemon.
#   Default: undef
#
# [*sys_contact*]
#   Responsible person for the SNMP system.
#   Default: infra-sys@cdnetworks.com
#
# [*sys_location*]
#   Location of the SNMP system.
#   Default: Unknown
#
# [*sys_name*]
#   Name of the system (hostname).
#   Default: ${::fqdn}
#
# [*sys_services*]
#   For a host system, a good value is 72 (application + end-to-end layers).
#   Default: 72
#
# [*snmpv3_user*]
#   the user info hash
#   the argument should be this format
#   snmpv3_user = {
#     name => xxxx,
#     authtype => MD5 or SHA,
#     authpass => XXX,
#     privtype => DES or AES,
#     privpass => XXX,
#   }
#
## Variables
#
## Authors
#   Daehyung.lee <daehyung@gmail.com>
class profiles::snmp (
  $ro_community           = hiera('profiles::snmp::ro_community', undef),
  $sys_contact            = hiera('profiles::snmp::sys_contact', 'infra-sys@cdnetworks.com'),
  $sys_location           = hiera('profiles::snmp::sys_location', 'Unknown'),
  $sys_services           = hiera('profiles::snmp::sys_services', 72),
  $sys_name               = hiera('profiles::snmp::sys_name', $::fqdn),
  $snmpv3_user            = hiera_hash('profiles::snmp::snmpv3_user', false),
){

  if $snmpv3_user {
    validate_hash($snmpv3_user)
    snmp::snmpv3_user { $snmpv3_user[name] :
      authtype => $snmpv3_user[authtype],
      authpass => $snmpv3_user[authpass],
      privtype => $snmpv3_user[privtype],
      privpass => $snmpv3_user[privpass],
    }
  }

  $ip = $::networking['ip']
  $ip6 = $::networking['ip6']

  # TODO: @20161006 by daehyung.lee
  # current version of the net-snmp daemon could not be bound onto
  # ipv6 ip address. I don't know why I followed the instruction of the manpage
  # that's why I disabled it
  class { 'snmp':
    agentaddress => [
      'udp:127.0.0.1:161',
      'udp6:[::1]:161',
      "tcp:${ip}:161",
      #"tcp6:${ip6}:161",
      "udp:${ip}:161",
      #"udp6:${ip6}:161",
    ],
    ro_community => $ro_community,
    location     => $sys_location,
    contact      => $sys_contact,
    services     => $sys_services,
    sysname      => $sys_name,
  }
}
