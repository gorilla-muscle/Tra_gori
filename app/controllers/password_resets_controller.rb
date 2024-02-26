class PasswordResetsController < ApplicationController
  skip_before_action :require_login
  before_action :load_user_token, only: %i[edit update]

  def new; end

  def edit
    not_authenticated if @user.blank?
  end

  def create
    @user = User.find_by(email: params[:email])
    @user&.deliver_reset_password_instructions!

    flash[:success] = t(".success")
    redirect_to login_path
  end

  def update
    return not_authenticated if @user.blank?

    @user.password_confirmation = params[:user][:password_confirmation]
    process_password_change(@user)
  end

  private

  def load_user_token
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)
  end

  def process_password_change(user)
    if user.change_password(params[:user][:password])
      flash[:success] = t(".change_password")
      redirect_to login_path
    else
      flash.now[:alert] = t(".not_change_password")
      render :edit, status: :unprocessable_entity
    end
  end
end
