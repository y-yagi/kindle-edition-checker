class AddNotifiedToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :notified, :boolean, default: :false
  end
end
