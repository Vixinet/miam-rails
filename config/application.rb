require_relative 'boot'

require "rails"

require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"
# require "action_mailer/railtie"
# require "active_job/railtie"
# require "action_cable/engine"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Miam

  DELIVERY_INFO = {
    :base_price_chf => 4.90,
    :base_range_km => 1.5,
    :premium_range_km => 1.5,
    :premium_price_chf => 3.0,
    :free_delivery_cap_chf => 100,
    :small_order_cap_chf => 10
  }

  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded
    config.generators do |g|
      g.jbuilder          false
      g.test_framework    nil
    end
  end
end
