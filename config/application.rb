require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TraGori
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.generators do |g|
      g.assets          false          # assets以下のファイル(CSS, JavaScriptファイル)を作成しない 
      g.helper          false          # helper以下にファイルを作成しない 
      g.test_framework :rspec,
        view_specs: false,
        helper_specs: false,
        routing_specs: false
    end               

    config.i18n.default_locale = :ja

    config.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.yml').to_s]

    config.beginning_of_week = :sunday
    
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    
    config.active_job.queue_adapter = :Sidekiq
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
