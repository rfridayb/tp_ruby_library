class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username, limit: 250, null: false
      t.string :password_digest, limit: 250, null: false

      t.timestamps
    end
  end
end
