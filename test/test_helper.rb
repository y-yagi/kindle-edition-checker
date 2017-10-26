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

class ActionDispatch::IntegrationTest
  fixtures :all
  include Capybara::DSL

  require 'capybara/poltergeist'
  Capybara.javascript_driver = :poltergeist

  def login
    visit '/auth/google_oauth2'
  end
end
