class GachasController < ApplicationController

  def new; end

  def create
    if current_user.number_of_banana.count >= 5
      current_user.number_of_banana.decrement!(:count, 5)

      unacquired_illustrations = Illustration.where.not(id: current_user.illustrations.pluck(:id))
      @illustration = unacquired_illustrations.order("RANDOM()").first

      if @illustration
        current_user.illustrations << @illustration
        redirect_to result_gacha_path(@illustration)
      else
        flash[:warning] = t(".all_acquired")
        redirect_to training_records_path
      end

    else
      flash[:alert] = t(".shortage_banana")
      render :new, status: :unprocessable_entity
    end
  end

  def result
    @illustration = Illustration.find(params[:id])
  end
end
