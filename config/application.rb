require_relative "boot"

require "rails/all"
require './app/middlewares/request_logger'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SnortManagement
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Rack CORS configurations
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: %i(get post options put delete)
      end
    end

    # Allow exceptions to be propagated to Raven::Rack middleware
    # config.action_dispatch.show_exceptions = false

    config.middleware.insert_after Rails::Rack::Logger, ::RequestLogger
  end
end
