class Admin::ProductVariationsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user
  before_action :set_product_variation, only: [:edit, :update, :destroy]

  layout 'admin'

  # GET /admin/product/1/product_variations/new
  def new
    @product_variation = ProductVariation.new
  end

  # GET /admin/product_variations/1/edit
  def edit
  end

  # POST /admin/product/1/product_variations
  def create
    @product_variation = ProductVariation.new(product_variation_params)
    @product_variation.product = Product.find(params[:product_id])

    if @product_variation.save
      flash[:success] = 'Product variation was successfully created.'
      redirect_to admin_product_url(@product_variation.product)
    else
      flash[:danger] = 'Product variation was *NOT* successfully created.'
      render :new
    end
  end

  # PATCH/PUT /admin/product_variations/1
  def update
    if @product_variation.update(product_variation_params)
      flash[:success] = 'Product was successfully updated.'
      redirect_to admin_product_url(@product_variation.product)
    else
      flash[:danger] = 'Product variation was *NOT* successfully updated.'
      render :edit
    end
  end

  # DELETE /admin/product_variations/1
  def destroy
    @product_variation.destroy
    redirect_to admin_product_url(@product_variation.product)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_variation
      @product_variation = ProductVariation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_variation_params
      params.require(:product_variation).permit(:label, :allow_multi_choices, :multi_choice_limit)
    end
end
