class UsersProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def show
    @latest_weight_record = current_user.weight_records.order(created_at: :desc).first
    @weight_record = WeightRecord.new
    @today_weight_record = WeightRecord.weight_record_for_day(current_user)
  end

  def edit
    @user.build_users_profile unless @user.users_profile
  end

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
    params.require(:user).permit(:name, :email, users_profile_attributes: [:id, :target_weight])
  end
end
