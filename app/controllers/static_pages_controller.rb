class StaticPagesController < ApplicationController
  
  layout 'app'
  
  def home
  	@city = City.new
  	@cities = City.all.where(status: :live).order(:votes).reverse

  	@opt_in = OptIn.new
  end

  def support
  end
end
