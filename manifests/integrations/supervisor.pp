# Class: datadog_agent::integrations::supervisor
#
# This class will install the necessary configuration for the supervisor integration
#
# Parameters:
#   $instances:
#       Array of hashes for all supervisord servers. See example
#
# Sample Usage:
#
#   class { 'datadog_agent::integrations::supervisor':
#     instances => [
#         {
#             'name'  => 'server0',
#             'host'  => 'localhost',
#             'port'  => '9001'
#         },
#         {
#             'name'  => 'server1',
#             'host'  => 'localhost',
#             'port'  => '9002'
#         },
#     ],
#   }
#
#
#
class datadog_agent::integrations::supervisor(
  $instances = [],
) inherits datadog_agent::params {

  validate_array($instances)

  file { "${datadog_agent::params::conf_dir}/supervisord.yaml":
    ensure  => file,
    owner   => $datadog_agent::params::dd_user,
    group   => $datadog_agent::params::dd_group,
    mode    => '0600',
    content => template('datadog_agent/agent-conf.d/supervisord.yaml.erb'),
    require => Package[$datadog_agent::params::package_name],
    notify  => Service[$datadog_agent::params::service_name]
  }
}
