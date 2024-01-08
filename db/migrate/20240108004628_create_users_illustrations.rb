class CreateUsersIllustrations < ActiveRecord::Migration[7.0]
  def change
    create_table :users_illustrations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :illustration, null: false, foreign_key: true

      t.timestamps
    end
  end
end
