class TrainingRecordsController < ApplicationController
  before_action :require_login

  def index
    @records = current_user.training_records
    @record = TrainingRecord.new(start_time: Time.current)
  end

  def create
    @record = current_user.training_records.build(record_params)

    if @record.save
      redirect_to training_records_path
    else
      redirect_to root_path
    end
  end

  def show
    @record = TrainingRecord.find(params[:id])
  end

  private

  def record_params
    params.require(:training_record).permit(:sport_content, :start_time)
  end
end
