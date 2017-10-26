require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  setup do
    stub_request(:post, "https://fcm.googleapis.com/fcm/send").
      with(body: "{\"registration_ids\":[null]}",
           headers: {'Authorization'=>'key=', 'Content-Type'=>'application/json'}).
      to_return(status: 200, body: "", headers: {})
  end

  test 'send! should update notification status' do
    book = books(:has_kindle_edition)
    assert_not book.notified

    Notification.send!

    book.reload
    assert book.notified
  end
end
