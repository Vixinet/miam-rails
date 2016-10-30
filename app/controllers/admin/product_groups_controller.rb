class Admin::ProductGroupsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user
  before_action :set_product_group, only: [:show, :edit, :update, :destroy]

  layout 'admin'

  # GET /admin/product_groups/1
  def show
  end

  # GET /admin/venues/1/product_groups/new
  def new
    @product_group = ProductGroup.new
  end

  # GET /admin/product_groups/1/edit
  def edit
  end

  # POST /admin/venues/1/product_groups
  def create
    @product_group = ProductGroup.new(product_group_params)
    @product_group.venue = Venue.find(params[:venue_id])

    if @product_group.save
      flash[:success] = 'Product group was successfully created.'
      redirect_to admin_venue_url(@product_group.venue)
    else
      flash[:danger] = 'Product group was *NOT* successfully created.'
      render :new
    end
  end

  # PATCH/PUT /admin/product_groups/1
  def update
    if @product_group.update(product_group_params)
      flash[:success] = 'Product group was successfully updated.'
      redirect_to admin_venue_url(@product_group.venue)
    else
      flash[:danger] = 'Product group was *NOT* successfully updated.'
      render :edit
    end
  end

  # DELETE /admin/product_groups/1
  def destroy
    @product_group.destroy
    redirect_to admin_venue_url(@product_group.venue)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_group
      @product_group = ProductGroup.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_group_params
      params.require(:product_group).permit(:status, :label, :description, :order)
    end
end
