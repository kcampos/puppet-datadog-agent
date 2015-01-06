# Will add integrations from hiera config
class datadog_agent::add_integrations inherits datadog_agent::params {
  
  if has_key($integrations, 'process') {
    class { 'datadog_agent::integrations::process': processes => $integrations['process'] }
  }

  if has_key($integrations, 'http') {
    class { 'datadog_agent::integrations::http_check': 
      http_checks => $integrations['http']['checks'],
      notify      => $integrations['http']['notify']
    }
  }
}
