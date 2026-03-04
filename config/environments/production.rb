require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Code is not reloaded between requests.
  config.enable_reloading = false

  # Eager load code on boot for better performance.
  config.eager_load = true

  # Full error reports are disabled.
  config.consider_all_requests_local = false

  # Enable caching.
  config.action_controller.perform_caching = true

  # Cache assets for far-future expiry.
  config.public_file_server.headers = {
    "cache-control" => "public, max-age=#{1.year.to_i}"
  }

  # Log to STDOUT (required for Render)
  config.log_tags = [ :request_id ]
  config.logger   = ActiveSupport::TaggedLogging.logger(STDOUT)

  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # Prevent health checks from clogging logs
  config.silence_healthcheck_path = "/up"

  # Disable deprecation reports
  config.active_support.report_deprecations = false

  # Use simple in-memory cache (no Solid Cache)
  config.cache_store = :memory_store

  # Enable locale fallbacks
  config.i18n.fallbacks = true

  # Do not dump schema after migrations
  config.active_record.dump_schema_after_migration = false

  # Only use :id for inspections in production
  config.active_record.attributes_for_inspect = [ :id ]
end
