class ChangeUniqueIndexToAuthentications < ActiveRecord::Migration[7.0]
  def change
    remove_index :authentications, [:provider, :uid]
    add_index :authentications, [:provider, :uid], unique: true
  end
end
