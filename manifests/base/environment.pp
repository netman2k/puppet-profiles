# Class: profiles::base::environment
#  This class manages environment variables
#  which are stored in the /etc/profile.d directory
#
## Parameters
#    [*env_hash*]
#      The content of the /etc/profile.d to set
#      Example:
#        '10-environment.sh' => {
#           'JAVA_HOME' => '/usr/java/jdk-1.9.0'
#           'PATH'     => '$JAVA_HOME/bin:/usr/local/abc/bin:$PATH',
#        }
#
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
