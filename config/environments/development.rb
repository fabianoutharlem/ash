Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  config.domain = 'http://localhost:3000'

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  config.action_mailer.perform_deliveries = true

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
      address:              'smtp.mandrillapp.com',
      port:                 587,
      domain:               'ash.fabianoudhaarlem.nl',
      user_name:            'michael@merqwaardig.com',
      password:             'dEB7CqN5RGv4Di7w9113Qw',
      authentication:       'login',
      enable_starttls_auto: true
  }

  config.action_mailer.asset_host = config.domain
  config.asset_host = config.domain

  Rails.application.routes.default_url_options[:host] = config.domain

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  config.identity_cache_store = :dalli_store

  # GA_TRACKER = Staccato.tracker('UA-55394434-1')

end
