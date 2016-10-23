namespace :notification do
  desc "notify by email"
  task email: :environment do
    users = User.includes(:books).references(:books).merge(Book.unnotified)

    users.each do |user|
      UserMailer.kindle_notification(user, user.books.unnotified).deliver_now
    end
  end
end
