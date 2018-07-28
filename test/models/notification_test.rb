require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  setup do
    stub_request(:post, "https://fcm.googleapis.com/fcm/send").
      with(
        body: "{\"registration_ids\":[null],\"notification\":{\"title\":\"Kindle版がamazonに登録されました\",\"body\":\"スケッチブック 12 (BLADE COMICS)  発売日: 2016-10-17\\nhttps://www.amazon.co.jp/dp/4800006198/\\n\",\"click_action\":\"http://localhost:3000/books\",\"icon\":\"icon.png\"}}",
        headers: {
        'Authorization'=>'key=',
        'Content-Type'=>'application/json'
        }).
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
