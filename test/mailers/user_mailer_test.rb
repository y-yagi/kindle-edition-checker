require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "kindle_notification" do
    user = users(:google)
    mail = UserMailer.kindle_notification(user, user.books.unnotified)
    assert_equal "[Kindle Edition Checker]Kindle版の発売日をお知らせします", mail.subject
    assert_equal [user.email], mail.to
    assert_equal %w(noreply@kindle-edition-checker.herokuapp.com), mail.from
    assert_match "下記書籍のKindle版がamazonに登録されたのでお知らせします。\r\n\r\n  スケッチブック 12 (BLADE COMICS)  発売日: 2016-10-17\r\n  https://www.amazon.co.jp/dp/4800006198/\r\n\r\n", mail.body.encoded
  end
end
