module Notifications
  class Pushbullet
    TITLE = 'KindleEditionChecker'.freeze

    def send(user)
      ::Pushbullet.api_token = user.raw_pushbullet_api_token
      devices = ::Pushbullet::Device.all

      devices.each do |device|
        device.push_note(TITLE, body(user))
      end
      ::Pushbullet.api_token = nil
    end

    def body(user)
      body = "下記書籍のKindle版がamazonに登録されたのでお知らせします。\n"
      user.books.each do |book|
        body += "#{book.title}  発売日: #{book.kindle_edition_release_date}\n#{book.amazon_url}\n"
      end
      body
    end
  end
end
