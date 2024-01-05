class TrainingRecordsController < ApplicationController
  before_action :require_login

  def index
    @records = user_training_records
    @record = TrainingRecord.new(start_time: Time.current)
    @today_record = user_training_records.where("Date(start_time) = ?", Date.today).first
  end

  def create
    if TrainingRecord.check_report?(current_user)
      flash[:warning] = t(".reported")
      redirect_to training_records_path
    else 
      @record = current_user.training_records.build(record_params)
      if @record.save
        @record.update(bot_content: generate_openai_compliment(@record.sport_content))
        redirect_to training_reports_path(record_id: @record.id)
      else
        redirect_to root_path
      end
    end
  end

  def show
    @record = TrainingRecord.find(params[:id])
  end

  private

  def user_training_records
    current_user.training_records
  end

  def record_params
    params.require(:training_record).permit(:sport_content, :start_time)
  end

  def generate_openai_compliment(sport_content)
    OpenaiComplimentGenerator.generate_compliment(sport_content)
  end
end
