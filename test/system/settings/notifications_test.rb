require "application_system_test_case"

class Settings::NotifcaitonsTest < ApplicationSystemTestCase
  setup do
    login
    visit settings_notifications_path
  end

  test 'update notification settings' do
    fill_in 'user_pushbullet_api_token', with: 'pushbullet_token'
    click_button '更新'
    assert_equal 'pushbullet_token', login_user.reload.raw_pushbullet_api_token

    check 'user_pushbullet_notification'
    click_button '更新'
    assert_equal 'pushbullet_token', login_user.reload.raw_pushbullet_api_token
  end
end
