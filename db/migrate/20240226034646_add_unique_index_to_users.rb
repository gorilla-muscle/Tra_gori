class AddUniqueIndexToUsers < ActiveRecord::Migration[7.0]
  def change
    remove_index :users, :reset_password_token
    add_index :users, :reset_password_token, unique: true
  end
end
