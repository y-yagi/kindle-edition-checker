namespace :notification do
  desc "notify by email"
  task email: :environment do
    users = User.where(email_notification: true).includes(:books).references(:books).merge(Book.unnotified)

    users.each do |user|
      UserMailer.kindle_notification(user, user.books.unnotified).deliver_now
      user.books.update_all(notified: true)
    end
  end

  desc "notify by fcm"
  task fcm: :environment do
    firebase = Notification::Firebase.new
    users = User.where(browser_notification: true).includes(:books).references(:books).merge(Book.unnotified)

    users.each do |user|
      response = firebase.send([user.browser_subscription_id])
      # TODO: need to check response
    end
  end
end
