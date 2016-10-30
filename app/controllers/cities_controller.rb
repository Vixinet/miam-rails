class CitiesController < ApplicationController

  # POST /cities
  def create
    @city = City.find_or_create_by(city_params)
    @city.votes += 1;

    respond_to do |format|
      if @city.save
        format.js   {}
      else
        format.js { "alert(1)" }
      end
    end
  end

  private
    def city_params
      params.require(:city).permit(:label)
    end
end
