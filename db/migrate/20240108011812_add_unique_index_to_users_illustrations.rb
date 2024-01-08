class AddUniqueIndexToUsersIllustrations < ActiveRecord::Migration[7.0]
  def change
    add_index :users_illustrations, [:user_id, :illustration_id], unique: true
  end
end
