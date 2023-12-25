class AddStartTimeToTrainingRecords < ActiveRecord::Migration[7.0]
  def change
    add_column :training_records, :start_time, :datetime
  end
end
