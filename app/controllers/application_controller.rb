class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def not_authenticated
    flash[:warning] = t("not_authenticated.warning")
    redirect_to login_path
  end

  def authenticated
    if logged_in?
      flash[:warning] = t("authenticated.warning")
      redirect_to training_records_path
    end
  end
end
