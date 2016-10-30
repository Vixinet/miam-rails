class Admin::CitiesController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user
  before_action :set_city, only: [:show, :edit, :update, :destroy]

  layout 'admin'

  # GET /cities
  def index
    @cities = City.all.order(:votes).reverse_order
  end

  # GET /cities/new
  def new
    @city = City.new
  end

  # GET /cities/1/edit
  def edit
  end

  # POST /cities
  def create
    @city = City.new(city_params)
    if @city.save
      flash[:success] = "City created"
      redirect_to admin_cities_url
    else
      flash[:danger] = "Can't create city"
      render :new
    end
  end

  # PATCH/PUT /cities/1
  def update
    if @city.update(city_params)
      flash[:success] = "City updated"
      redirect_to admin_cities_url
    else
      flash[:danger] = "Can't update city"
      render :edit
    end
  end

  # DELETE /cities/1
  def destroy
    @city.destroy
    flash[:success] = "City deleted"
    redirect_to admin_cities_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city
      @city = City.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def city_params
      params.require(:city).permit(:status, :label, :votes)
    end
end
