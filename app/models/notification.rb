class Notification
  class << self
    def send!
      users = User.where(browser_notification: true).or(User.where(pushbullet_notification: true))
        .includes(:books).references(:books).merge(Book.unnotified)

      firebase = Notifications::Firebase.new
      pushbullet = Notifications::Pushbullet.new

      users.each do |user|
        if user.browser_notification
          response = firebase.send([user.browser_subscription_id])
          Rollbar.error(response) if response[:response] != 'success'
        end

        begin
          pushbullet.send(user) if user.pushbullet_notification
        rescue => e
          Rails.logger.error(e)
          Rollbar.error(e)
        end
        user.books.unnotified.update_all(notified: true)
      end
    end
  end
end
