class CreateUsersProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :users_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.float :target_weight
      t.boolean :line_notify_on

      t.timestamps
    end
  end
end
