require_relative 'boot'

require 'rails/all'

require 'sidekiq'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)



module App
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.


	# config.action_mailer.asset_host = 'https://coindexter.io'
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    config.assets.paths << Rails.root.join("app", "services")
    config.active_job.queue_adapter = :sidekiq

  end
end
