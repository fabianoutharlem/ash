require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ash
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.assets.precompile += [ 'admin/appviews.css', 'admin/cssanimations.css', 'admin/dashboards.css', 'admin/forms.css', 'admin/gallery.css', 'admin/graphs.css', 'admin/mailbox.css', 'admin/miscellaneous.css', 'admin/pages.css', 'admin/tables.css', 'admin/uielements.css', 'admin/widgets.css', 'admin/commerce.css' ]
    config.assets.precompile += [ 'admin/appviews.js', 'admin/cssanimations.js', 'admin/dashboards.js', 'admin/forms.js', 'admin/gallery.js', 'admin/graphs.js', 'admin/mailbox.js', 'admin/miscellaneous.js', 'admin/pages.js', 'admin/tables.js', 'admin/uielements.js', 'admin/widgets.js', 'admin/commerce.js' ]
    config.assets.precompile += ["fontawesome-webfont.ttf", "fontawesome-webfont.eot", "fontawesome-webfont.svg", "fontawesome-webfont.woff"]


    config.to_prepare do
      devise_layout = 'admin/layouts/empty'
      Devise::SessionsController.layout devise_layout
      Devise::RegistrationsController.layout devise_layout
      Devise::ConfirmationsController.layout devise_layout
      Devise::UnlocksController.layout devise_layout
      Devise::PasswordsController.layout devise_layout
    end

  end
end
