# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/kindle_notification
  def kindle_notification
    user = User.first
    UserMailer.kindle_notification(user, user.books)
  end

end
