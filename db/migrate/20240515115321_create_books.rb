class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title, limit: 250
      t.string :author, limit: 250
      t.integer :publication_year

      t.timestamps
    end
  end
end
