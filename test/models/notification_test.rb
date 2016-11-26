require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  test 'send! should update notification status' do
    book = books(:has_kindle_edition)
    assert_not book.notified

    VCR.use_cassette('Notication.send!') { Notification.send! }

    book.reload
    assert book.notified
  end
end
