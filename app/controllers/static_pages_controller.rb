class StaticPagesController < ApplicationController
  skip_before_action :require_login
  
  def top; end

  def term; end

  def privacy; end

  def contact; end
end
