class profiles::base {
  $_motd_content =  "__________________________________________________________
/ Q:      What's tiny and yellow and very, very, dangerous? \
\ A:      A canary with the super-user password.            /
 -----------------------------------------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     || "  

  file { '/etc/motd':
    ensure  => file,
    content => $_motd_content,
  }


  Firewall {
    before  => Class['profiles::firewall::post'],
    require => Class['profiles::firewall::pre'],
  }

}
