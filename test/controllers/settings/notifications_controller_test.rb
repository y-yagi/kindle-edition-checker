require 'test_helper'

class Settings::NotificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get settings_notifications_index_url
    assert_response :success
  end

end
