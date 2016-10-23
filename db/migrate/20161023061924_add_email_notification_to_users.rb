class AddEmailNotificationToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :email_notification, :boolean, default: :false
  end
end
