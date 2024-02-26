class UsersProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def show
    @latest_weight_record = current_user.weight_records.order(created_at: :desc).first
    @weight_record = WeightRecord.new
    @today_weight_record = WeightRecord.weight_record_for_day(current_user)
    @weight_records = current_user.weight_records.order(created_at: :asc).pluck(:created_at, :weight)
    @min_weight = weight_min(@weight_records)
    @max_weight = weight_max(@weight_records)
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

  def weight_min(weight_records)
    min_weight, = weight_records.pluck(1).compact.minmax
    min_weight = min_weight.nil? ? 0 : min_weight - 5
    [min_weight, 0].max
  end

  def weight_max(weight_records)
    _, max_weight = weight_records.pluck(1).compact.minmax
    max_weight.nil? ? 0 : max_weight + 5
  end
end
