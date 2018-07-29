require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome

  def login
    visit '/auth/google_oauth2'
  end

  def login_user
    @login_user ||= User.find_by!(uid: 1, provider: 'google_oauth2')
  end
end
