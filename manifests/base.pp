class profiles::base {
  $_motd_content =  "\n* * * * * * * * * W A R N I N G * * * * * * * * * * *
This system is restricted to authorized users for
authorized use only. Unauthorized access is strictly
prohibited and may be punishable under the Computer
Fraud and Abuse Act of 1984 or other applicable laws.
All persons are hereby notified that the use of this
system constitutes consent to monitoring and auditing.
* * * * * * * * * * * * * * * * * * * * * * * * * * *\n"

  file { '/etc/motd':
    ensure  => file,
    content => $_motd_content,
  }

  resources { 'firewall':
      purge => true,
  }

  Firewall {
    before  => Class['profiles::firewall::post'],
    require => Class['profiles::firewall::pre'],
  }

  class { ['profiles::firewall::pre', 'profiles::firewall::post']: }
  class { 'firewall': }


  firewall { '200 accept HTTP':
    chain  => 'INPUT',
    state  => ['NEW'],
    dport  => '22',
    proto  => 'tcp',
    action => 'accept',
  }

}

