class AlbumsController < ApplicationController
  def index
    @illustrations = current_user.illustrations
  end

  def show
    @illustration = Illustration.find(params[:id])
  end
end
