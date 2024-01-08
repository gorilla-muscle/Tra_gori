class CreateNumberOfBananas < ActiveRecord::Migration[7.0]
  def change
    create_table :number_of_bananas do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :count, default: 5

      t.timestamps
    end
  end
end
