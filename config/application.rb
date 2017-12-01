require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module KindleChecker
  class Application < Rails::Application
    config.load_defaults "5.2"
    config.generators do |g|
      g.assets false
      g.helper false
    end

    config.i18n.default_locale = :ja
    config.time_zone = 'Tokyo'
  end
end
