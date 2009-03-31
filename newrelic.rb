app_name = ask "New Relic: What is the apps name?"
file 'config/newrelic.yml', <<-END
common: &default_settings
  license_key: '9558a5a7d79393854081ddef9dcc6e0c41f769d3'
  app_name: #{app_name}
  enabled: true
  log_level: info
  
  ssl: false
  capture_params: false
  transaction_tracer:
    enabled: true
    record_sql: obfuscated
    stack_trace_threshold: 0.500
  
  error_collector:
    enabled: true
    capture_source: true
        
development:
  <<: *default_settings
  enabled: false
  developer: true

test:
  <<: *default_settings
  enabled: false

production:
  <<: *default_settings
  enabled: true

staging:
  <<: *default_settings
  enabled: true
  app_name: My Application (Staging)
END

file 'install_new_relic', 'script/plugin install http://newrelic.rubyforge.org/svn/newrelic_rpm --force'