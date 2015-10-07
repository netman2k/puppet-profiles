class profiles::wordpress {

  include profiles::web

  ## Create user
  group { 'wordpress':
    ensure => present,
  }

  User <| title == $::apache::params::user |>{
    groups +> 'wordpress',
    require => Group['wordpress'],
  }

  user { 'wordpress':
    ensure   => present,
    gid      => 'wordpress',
    password => '$1$jrm5tnjw$h8JJ9mCZLmJvIxvDLjw1M/', #puppet
    home     => '/var/www/site/blog',
  }

  ## Configure wordpress
  class { '::wordpress':
    install_dir => '/var/www/site/blog',
    db_name     => 'wordpress',
    db_host     => 'localhost',
    db_user     => 'wordpress',
    db_password => 'wordpress',
    wp_owner    => 'wordpress',
    wp_group    => 'wordpress',
  }

  ## Configure vhost for wordpress
  apache::vhost { $::fqdn:
    port          => '80',
    docroot       => '/var/www/site',
    default_vhost => true,
  }
}
