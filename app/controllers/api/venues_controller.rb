class Api::VenuesController < ApplicationController
  before_action :set_venue, only: [:show]

  # GET /api/venues.json
  def index
    render json: Venue.where(status: :live).select(:id, :name, :title)
  end

  # GET /api/venues/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_venue
      @venue = Venue.find(params[:id])
    end

end
