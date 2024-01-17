class ChangeCloumnsAddNotnullOnTrainingRecords < ActiveRecord::Migration[7.0]
  def change
    change_column :training_records, :sport_content, :string, null: false
  end
end
