# Will add integrations from hiera config
class datadog_agent::add_integrations inherits datadog_agent::params {
  
  if has_key($integrations, 'process') {
    class { 'datadog_agent::integrations::process': processes => $integrations['process'] }
  }
}
