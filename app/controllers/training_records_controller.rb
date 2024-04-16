class TrainingRecordsController < ApplicationController
  def index
    @records = user_training_records
    @record = TrainingRecord.new(start_time: Time.current)
    @today_record = user_training_records.where("Date(start_time) = ?", Time.zone.today).first
  end

  def show
    @record = TrainingRecord.find(params[:id])
  end

  def create
    if TrainingRecord.check_report?(current_user)
      flash[:warning] = t(".reported")
      redirect_to training_records_path
    else
      @record = TrainingRecord.openai_response_handling(current_user, record_params)
      redirect_to training_reports_path(record_id: @record.id)
    end
  rescue OpenaiComplimentGenerator::OpenAIError => e
    flash[:alert] = e.message
    redirect_to training_records_path
  rescue StandardError => e
    flash[:alert] = e.message
    redirect_to training_records_path
  end

  private

  def user_training_records
    current_user.training_records
  end

  def record_params
    params.require(:training_record).permit(:sport_content, :start_time)
  end
end
