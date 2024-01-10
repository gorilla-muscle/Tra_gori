class AlbumsController < ApplicationController
  before_action :require_login

  def index
    @illustrations = current_user.illustrations
  end

  def show
    @illustration = Illustration.find(params[:id])
  end
end
