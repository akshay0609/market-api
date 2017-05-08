require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MarketPlaceApi
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  config.generators do |g|
	  g.test_framework :rspec, fixture: true
	  g.fixture_replacement :factory_girl, dir: 'spec/factories'
	  g.view_specs false
	  g.helper_specs false
	  g.stylesheets = false
	  g.javascripts = false
	  g.helper = false
	end

  config.action_mailer.default_url_options = { :host => 'localhost' }
  config.action_mailer.delivery_method = :sendmail
  config.action_mailer.perform_deliveries = true

	config.autoload_paths += %W(\#{config.root}/lib)
  end
end
