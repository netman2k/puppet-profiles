# == Class: profiles::snmp
# This class set the default configuration on snmpd.conf
#
# === Parameters
#
# === Variables
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
## Authors
#   Daehyung.lee <daehyung@gmail.com>
class profiles::snmp {

  $ro_community           = hiera('profiles::snmp::ro_community', undef
  $sys_contact            = hiera('profiles::snmp::sys_contact', 'infra-sys@cdnetworks.com'
  $sys_location           = hiera('profiles::snmp::sys_location', 'Unknown'
  $sys_services           = hiera('profiles::snmp::sys_services', 72
  $sys_name               = hiera('profiles::snmp::sys_name', $::fqdn
  $snmpv3_user            = hiera_hash('profiles::snmp::snmpv3_user', false
  $trapsink               = hiera('profiles::snmp::trapsink', undef
  $informsink             = hiera('profiles::snmp::informsink', undef
  $authtrapenable         = hiera('profiles::snmp::authtrapenable', undef
  $trapcommunity          = hiera('profiles::snmp::trapcommunity', undef
  $snmpd_options          = hiera('profiles::snmp::snmp_options', []

  if $snmpv3_user {
    validate_hash($snmpv3_user)
    # TODO: Check newest module whether support this
    # Current version of razersedge/snmp module could not handle
    # snmp v3 user creating correctly on CentOS 7
    # so I did not used snmp::snmpv3_user at this time.

    # ::snmp::snmpv3_user { $snmpv3_user['name'] :
    #   authtype => $snmpv3_user['authtype'],
    #   authpass => $snmpv3_user['authpass'],
    #   privtype => $snmpv3_user['privtype'],
    #   privpass => $snmpv3_user['privpass'],
    # }

    $_user = $snmpv3_user['name']
    $_authtype = $snmpv3_user['authtype']
    $_authpass = $snmpv3_user['authpass']
    $_privtype = $snmpv3_user['privtype']
    $_privpass = $snmpv3_user['privpass']

    $_creatUser_syntax = [ "rouser ${_user}",
      "createUser ${_user} ${_authtype} ${_authpass} ${_privtype} ${_privpass}",
    ]
  }else{
    warning('The snmpv3 user not defined via hiera or class Parameters')
    $_creatUser_syntax = []
  }

  $ip = $::networking['ip']
  $ip6 = $::networking['ip6']

  # TODO: @20161006 by daehyung.lee
  # current version of the net-snmp daemon could not be bound onto
  # ipv6 ip address. I don't know why I followed the instruction of the manpage
  # that's why I disabled it
  class { '::snmp':
    agentaddress => [
      'tcp:127.0.0.1:161',
      'tcp6:::1:161',
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
    snmpd_config => flatten([$_creatUser_syntax, $snmpd_options,])
  }

  # TODO: Firewall settings
}
