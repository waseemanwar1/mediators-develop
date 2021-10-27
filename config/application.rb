require_relative 'boot'

require 'rails/all'
require "view_component/engine"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Equisettle
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.action_mailer.preview_path = "#{Rails.root}/test/mailers/previews"
    config.autoload_paths << config.root.join('app/adapters', 'app/searches')
    config.active_job.queue_adapter = :sidekiq
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.default_locale = :en
    config.i18n.fallbacks = [
      I18n.default_locale,
      {
        ru: [:ru, :en, :tat],
        en: [:en, :ru, :tat],
        tat: [:tat, :ru, :en],
      }
    ]

    config.generators do |g|
      g.test_framework  :test_unit, fixture: true
    end
  end
end
