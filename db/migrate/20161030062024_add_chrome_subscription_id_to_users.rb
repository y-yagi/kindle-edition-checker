class AddChromeSubscriptionIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :chrome_subscription_id, :string
  end
end
