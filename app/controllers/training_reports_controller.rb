class TrainingReportsController < ApplicationController
  before_action :require_login
  before_action :report_conf

  def index; end

  private

  def report_conf
    unless TrainingRecord.check_report?(current_user)
      flash[:warning] = t(".not_report")
      redirect_to training_records_path
    end
  end
end
