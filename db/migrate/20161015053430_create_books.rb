class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :isbn_10, null: :false
      t.boolean :has_kindle_edition
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
