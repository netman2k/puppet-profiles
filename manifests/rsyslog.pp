class profiles::rsyslog(
  
){
  class { '::rsyslog': 
    preserve_fqdn => true,
    extra_modules => [ 'imklog' ],
  }
  class { '::rsyslog::client': 
  }
}
