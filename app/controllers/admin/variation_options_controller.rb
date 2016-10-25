class Admin::VariationOptionsController < ApplicationController
  before_action :set_min_variation_option, only: [:edit, :update, :destroy]

  layout 'admin'

  # GET /admin/product_variation/1/variation_options/new
  def new
    @variation_option = VariationOption.new
  end

  # GET /admin/variation_options/1/edit
  def edit
  end

  # POST /admin/product_variations/1/variation_options
  def create
    @variation_option = VariationOption.new(variation_option_params)
    flash[:success] = params[:product_variation_id]
    @variation_option.product_variation = ProductVariation.find(params[:product_variation_id])
    
    if @variation_option.save
      flash[:success] = 'Variation option was successfully created.'
      redirect_to admin_product_url(@variation_option.product_variation.product)
    else
      flash[:danger] = 'Product was *NOT* successfully created.'
      render :new
    end
  end

  # PATCH/PUT /admin/variation_options/1
  def update
    if @variation_option.update(variation_option_params)
      flash[:success] = 'Variation option was successfully updated.'
      redirect_to admin_product_url(@variation_option.product_variation.product)
    else
      flash[:danger] = 'Product was *NOT* successfully updated.'
      render :edit
    end
  end

  # DELETE /admin/variation_options/1
  def destroy
    @variation_option.destroy
    redirect_to admin_product_url(@variation_option.product_variation.product)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_min_variation_option
      @variation_option = VariationOption.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def variation_option_params
      params.require(:variation_option).permit(:label, :allow_multi_choices, :price_variation)
    end
end
