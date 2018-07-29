class Notifications::Firebase
  def initialize
    @fcm = FCM.new(Rails.application.secrets.fcm_server_key)
  end

  def send(user)
    title = "Kindle版がamazonに登録されました"
    options = { notification: { title: title, body: body(user), click_action: Rails.application.config.x.notification.click_action, icon: 'icon.png' } }
    @fcm.send([user.browser_subscription_id], options)
  end

  def body(user)
    message = ""
    user.books.each do |book|
      message += "#{book.title}  発売日: #{book.kindle_edition_release_date}\n#{book.amazon_url}\n"
    end
    message
  end
end
