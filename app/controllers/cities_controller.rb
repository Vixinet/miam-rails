class CitiesController < ApplicationController

  # POST /cities/1/vote
  def vote
    @city = City.find(params[:id])
    @city.votes += 1;

    respond_to do |format|
      if @city.save
        cookies.permanent[:voted_city] = params[:id]
        format.js { render :nothing => true }
      else
        format.js { render :nothing => true, :status => 400 }
      end
    end
  end

  # POST /cities
  def create
    @city = City.where('lower(label) = ?', city_params[:label].downcase).first 
    @city ||= City.create(city_params)
    @city.votes += 1;

    respond_to do |format|
      if @city.save
        format.js { render :nothing => true }
      else
        format.js { render :nothing => true, :status => 400 }
      end
    end
  end
  
  private
    def city_params
      params.require(:city).permit(:label)
    end
end
