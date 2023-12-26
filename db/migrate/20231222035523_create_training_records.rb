class CreateTrainingRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :training_records do |t|
      t.references :user, null: false, foreign_key: true
      t.string :sport_content
      t.string :bot_content

      t.timestamps
    end
  end
end
