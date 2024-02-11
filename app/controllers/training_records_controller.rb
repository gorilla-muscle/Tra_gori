class TrainingRecordsController < ApplicationController
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
      begin
        ActiveRecord::Base.transaction do
          @record.save!
          bot_content = generate_openai_compliment(@record.sport_content)
          @record.update!(bot_content: bot_content)
          current_user.number_of_banana.increment!(:count, 1)
          redirect_to training_reports_path(record_id: @record.id)
        end
      rescue OpenAI::Error => e
        flash[:alert] = "#{e.message}"
        redirect_to training_records_path
      rescue => e
        flash[:alert] = "保存に失敗しました。管理者にお問い合わせ下さい。 "
        redirect_to training_records_path
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
