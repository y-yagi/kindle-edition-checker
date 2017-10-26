ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'webmock/minitest'
require 'capybara/rails'

WebMock.disable_net_connect!(allow_localhost: true)

class ActiveSupport::TestCase
  fixtures :all
end

OmniAuth.config.test_mode = true
OmniAuth.config.add_mock(:google_oauth2,
  'uid' => '1',
  'provider' => 'google_oauth2',
)
