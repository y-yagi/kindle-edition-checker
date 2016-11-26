require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should have the necessary required validators' do
    user = User.new(pushbullet_notification: true)
    assert_not user.valid?
    assert_equal [:pushbullet_api_token], user.errors.keys
  end

  test 'return exist user data when provider and uid match' do
    auth = { 'provider' => 'google_oauth2', 'uid' => 1 }
    user = User.find_or_create_from_auth_hash(auth)

    assert_equal users(:google).id, user.id
  end

  test 'return new user data when provider and uid not match' do
    auth = {
      'provider' => 'google_oauth2', 'uid' => 2,
      'info' => { 'email' => 'test2@google.com', 'name' => 'test2' }
    }
    user = User.find_or_create_from_auth_hash(auth)

    assert_not_equal users(:google).id, user.id
  end

  test 'update user info when email changed' do
    user = users(:google)
    new_email = user.email + "_new"
    auth = {
      'provider' => 'google_oauth2', 'uid' => 2,
      'info' => { 'email' => new_email }
    }
    user.update_if_needed!(auth)

    assert_equal new_email, user.email
  end

  test 'encrypt pushbullet_api_token when saved' do
    user = users(:google)
    user.pushbullet_api_token = 'pushbullet_api_token'
    user.save!

    assert_not_equal 'pushbullet_api_token', user.pushbullet_api_token
    assert_equal 'pushbullet_api_token', user.raw_pushbullet_api_token
  end
end
