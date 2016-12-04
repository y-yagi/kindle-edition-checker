class AddReleaseDateToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :release_date, :date
  end
end
