class VenuesController < ApplicationController
  before_action :set_venue, only: [:show]

  layout 'app'

  # GET /venues
  def index
    @venues = Venue.where(:status => :live)
    @venues = Venue.all
  end

  # GET /venues/1
  def show
    @order = Order.new(:venue => @venue)
  end

  private
    def set_venue
      @venue = Venue.find_by_slug(params[:id])
    end

end
