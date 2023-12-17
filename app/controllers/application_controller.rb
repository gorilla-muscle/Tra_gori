class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def not_authenticated
    flash[:warning] = t(".warning")
    redirect_to login_path
  end

  def authenticated
    if logged_in?
      flash[:warning] = t(".warning")
      redirect_to root_path
    end
  end
end
