class GachasController < ApplicationController
  def new; end

  def create
    if current_user.number_of_banana.count >= 5
      current_user.decrement_banana_count
      not_possessed_illustrations
    else
      flash[:alert] = t(".shortage_banana")
      render :new, status: :unprocessable_entity
    end
  end

  def result
    @illustration = Illustration.find(params[:id])
  end

  private

  def not_possessed_illustrations
    unacquired_illustrations = Illustration.where.not(id: current_user.illustrations.pluck(:id))
    @illustration = unacquired_illustrations.order("RANDOM()").first
    confirmation_illustrations(@illustration)
  end

  def confirmation_illustrations(illustration)
    if illustration
      current_user.illustrations << illustration
      redirect_to result_gacha_path(illustration)
    else
      flash[:warning] = t(".all_acquired")
      redirect_to training_records_path
    end
  end
end
