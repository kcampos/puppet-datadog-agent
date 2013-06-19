# Class: datadog
#
# This class contains the agent installation mechanism for the Datadog module
#
# Parameters:
#   $api_key:
#       Your DataDog API Key. Please replace with your key value
#   $puppet_run_reports
#       Will send results from your puppet agent runs back to the datadog service
#   $puppetmaster_user
#       Will chown the api key used by the report processor to this user.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# include datadog
#
# or
#
# class{'datadog': api_key => 'your key'}
#
#
class datadog::integrations::mysql(
  $host,
  $password,
  $user = 'datadog',
  $tags = [],
  $replication = '0',
  $galera_cluster = '1'
) inherits datadog::params {

  package { $mysql_int_package :
    ensure => installed,
  }

  file { "${conf_dir}/mysql.yaml":
    ensure  => file,
    owner   => $dd_user,
    group   => $dd_group,
    mode    => 0644,
    content => template('datadog/mysql.yaml.erb'),
    require => Package[$mysql_int_package],
    notify  => Service[$service_name]
  }
}
