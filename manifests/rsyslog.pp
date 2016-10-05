#  
# @param log_local_config_1 
#   Default setting for local logging
# @param action_queue_timeout_enqueue
#  reference: http://www.rsyslog.com/doc/v7-stable/concepts/queues.html#filled-up-queues
class profiles::rsyslog(
  $rate_limit_interval = undef,
  $mainmsg_queue_timeout_enqueue = 0,
  $action_queue_timeout_enqueue = 0,
  $log_local_config_1 = [ 'local6.notice  /var/log/bash' ],
  $log_local_config_2 = [],
  $remote_servers = hiera_hash('profiles::rsyslog::remote_servers', false),
  $enable_firewall = true,
){

#  $modules = [
#    '$ModLoad imuxsock # provides support for local system logging',
#    '$ModLoad imjournal # provides access to the systemd journal',
#    '$ModLoad imklog   # provides kernel logging support (previously done by rklogd)',
#    '#$ModLoad immark  # provides --MARK-- message capability',
#  ]


  # Custom settings for local log
  $_log_local_custom = flatten([
    '', # JUST LEAVE IT FOR SPACING BETWEEN COMMENT AND THIS
    $log_local_config_1,
    $log_local_config_2,
    "# Discard all incoming messages when queue is full",
    "\$MainMsgQueueTimeoutEnqueue ${mainmsg_queue_timeout_enqueue}",
  ])

  class { '::rsyslog':
    preserve_fqdn => true,
#    modules       => $modules,
  }

  class { '::rsyslog::client':
    log_local             => true,
    log_local_custom      => join($_log_local_custom, "\n"),
    spool_timeoutenqueue  => $action_queue_timeout_enqueue,
    rate_limit_interval   => $rate_limit_interval,
    remote_servers        => $remote_servers,
  }

}
