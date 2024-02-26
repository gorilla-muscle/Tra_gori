class WeightRecordsController < ApplicationController
  before_action :set_weight_record, only: %i[update]

  def create
    @weight_record = current_user.weight_records.new(weight_params)
    if @weight_record.save
      flash[:success] = t(".save_weight")
    else
      flash[:alert] = t(".not_save_weight")
    end
    redirect_to users_profiles_path
  end

  def update
    if @weight_record.update(weight_params)
      flash[:success] = t(".update_weight")
      redirect_to users_profiles_path
    else
      flash[:alert] = t(".not_update_weight")
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_weight_record
    @weight_record = current_user.weight_records.find(params[:id])
  end

  def weight_params
    params.require(:weight_record).permit(:weight)
  end
end
