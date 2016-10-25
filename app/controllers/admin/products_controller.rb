class Admin::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  layout 'admin'

  # GET /admin/products/1
  def show
  end

  # GET /admin/venues/1/products/new
  def new
    @product = Product.new
  end

  # GET /admin/products/1/edit
  def edit
  end

  # POST /admin/venues/1/products
  def create
    @product = Product.new(product_params)
    @product.product_group = ProductGroup.find(params[:product_group_id])

    if @product.save
      flash[:success] = 'Product was successfully created.'
      redirect_to admin_venue_url(@product.product_group.venue)
    else
      flash[:danger] = 'Product was *NOT* successfully created.'
      render :new
    end
  end

  # PATCH/PUT /admin/products/1
  def update
    if @product.update(product_params)
      flash[:success] = 'Product was successfully updated.'
      redirect_to admin_venue_url(@product.product_group.venue)
    else
      flash[:danger] = 'Product was *NOT* successfully updated.'
      render :edit
    end
  end

  # DELETE /admin/products/1
  def destroy
    @product.destroy
    redirect_to admin_venue_url(@product.product_group.venue)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:product_group_id, :label, :description, :base_price, :status, :order)
    end
end
