class Admin::VenuesController < ApplicationController
  before_action :set_venue, only: [:show, :edit, :update, :destroy]

  layout 'admin'

  # GET /venues
  def index
    @venues = Venue.all
  end

  # GET /venues/1
  def show
  end

  # GET /venues/new
  def new
    @venue = Venue.new
  end

  # GET /venues/1/edit
  def edit
  end

  # POST /venues
  def create
    @venue = Venue.new(venue_params)

    if @venue.save
      flash[:success] = 'Venue was successfully created.'
      redirect_to admin_venue_url(@venue)
    else
      flash[:danger] = 'Venue was *NOT* successfully created.'
      render :new
    end
  end

  # PATCH/PUT /venues/1
  def update
    if @venue.update(venue_params)
      flash[:success] = 'Venue was successfully updated.'
      redirect_to admin_venue_url(@venue)
    else
      flash[:danger] = 'Venue was *NOT* successfully updated.'
      render :edit
    end
  end

  # DELETE /venues/1
  def destroy
    @venue.destroy
    redirect_to admin_venues_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_venue
      @venue = Venue.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def venue_params
      params.require(:venue).permit(:status, :name, :title, :phone, :website, :merchant_id)
    end
end
