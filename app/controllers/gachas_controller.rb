class GachasController < ApplicationController

  def new; end

  def create
    if current_user.number_of_banana.count >= 5
      current_user.number_of_banana.decrement!(:count, 5)
      redirect_to training_records_path
    else
      flash[:alert] = t(".shortage_banana")
      render :new, status: :unprocessable_entity
    end
  end

  def result

  end
end
