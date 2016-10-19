# Class: profiles::base::environment
#  This class manages environment variables
#  which are stored in the /etc/profile.d directory
#
## Parameters
#    [*env_hash*]
#      The content of the /etc/profile.d to set
#      DSL Example:
#      {
#        '10-environment.sh' => "export PATH=/usr/local/bin:$PATH\n
#           [ -z $TMOUT ] && readonly TMOUT=900",
#        '20-kernel.sh' => "# Managed by Puppet\n
#           export DAEMON_COREFILE_LIMIT=unlimited"
#      }
#
#      Hiera Example:
#        profiles::base::environment::env_hash:
#         "10-environments.sh": |
#           # Managed by Puppet
#           export PATH=/usr/local/bin:$PATH
#           [ -z $TMOUT ] && readonly TMOUT=900
#         "20-kernel.sh": |
#           # Managed by Puppet
#           export DAEMON_COREFILE_LIMIT=unlimited
## Variables
#
## Authors
#   Daehyung Lee <daehyung@gmail.com>
class profiles::base::environment(
  $profile_d_dir = '/etc/profile.d',
  $env_hash = {}
){

  File {
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => 'root'
  }

  # It pretents a key is a filename and the value of a key is
  # a content of the file
  $env_hash.each |String $filename, String $content|{
    # Set environment variables in the /etc/profile.d
    file { $filename:
      path    => "${profile_d_dir}/${filename}",
      content => $content,
    }
  }


}
