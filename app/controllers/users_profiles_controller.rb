class UsersProfilesController < ApplicationController
  before_action :require_login
  before_action :set_user, only: %i[edit update]

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = t(".success")
      redirect_to users_profiles_path
    else
      flash.now[:alert] = t(".alert")
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
