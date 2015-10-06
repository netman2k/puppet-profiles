class profiles::db::php {
  class { 'mysql':
    php_enable => true,
  }
}
