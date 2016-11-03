class AddBrowserSubscriptionIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :browser_subscription_id, :string
  end
end
