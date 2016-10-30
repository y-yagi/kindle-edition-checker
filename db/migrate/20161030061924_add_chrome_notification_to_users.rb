class AddChromeNotificationToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :chrome_notification, :boolean, default: :false
  end
end
