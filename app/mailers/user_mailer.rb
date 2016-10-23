class UserMailer < ApplicationMailer
  def kindle_notification(user, books)
    @books = books
    mail to: user.email, subject: '[Kindle Edition Checker]Kindle版の発売日をお知らせします'
  end
end
