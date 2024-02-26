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
      @record = current_user.training_records.build(record_params)
      openai_response_handling(@record)
    end
  end

  private

  def user_training_records
    current_user.training_records
  end

  def record_params
    params.require(:training_record).permit(:sport_content, :start_time)
  end

  def openai_response_handling(record)
    ActiveRecord::Base.transaction do
      acquisition_response(record)
    end
    redirect_to training_reports_path(record_id: record.id)
  rescue OpenaiComplimentGenerator::OpenAIError => e
    flash[:alert] = e.message
    redirect_to training_records_path
  rescue StandardError
    flash[:alert] = "保存に失敗しました。管理者にお問い合わせ下さい。 "
    redirect_to training_records_path
  end

  def acquisition_response(record)
    record.save!
    bot_content = generate_openai_compliment(record.sport_content)
    # rubocop:disable Style/HashSyntax
    record.update!(bot_content: bot_content)
    # rubocop:enable Style/HashSyntax
    current_user.increment_banana_count
  end

  def generate_openai_compliment(sport_content)
    OpenaiComplimentGenerator.generate_compliment(sport_content)
  end
end
