class Admin::MerchantsController < ApplicationController
  before_action :set_merchant, only: [:show, :edit, :update, :destroy]

  layout 'admin'

  def index
    @merchants = Merchant.all
  end

  # GET /admin/merchants/1
  def show
  end

  # GET /admin/merchants/new
  def new
    @merchant = Merchant.new
  end

  # GET /admin/merchants/1/edit
  def edit
  end

  # POST /admin/merchants
  def create
    @merchant = Merchant.new(merchant_params)
    if @merchant.save
      flash[:success] = "Merchant created"
      redirect_to admin_merchant_path(@merchant)
    else
      flash[:danger] = "Can't create merchant"
      render :new
    end
  end

  # PATCH/PUT /admin/merchants/1
  def update
    if @merchant.update(merchant_params)
      flash[:success] = "Merchant updated"
      redirect_to admin_merchant_path(@merchant)
    else
      flash[:danger] = "Can't update merchant"
      render :edit
    end
  end

  # DELETE /admin/merchants/1
  def destroy
    @merchant.destroy
    flash[:success] = "Merchant deleted"
    redirect_to admin_merchants_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_merchant
      @merchant = Merchant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def merchant_params
      params.require(:merchant).permit(:status, :name, :title, :email, :phone, :website, :address, :city, :zipcode, :price, :delivery_cost, :free_delivery_limit, :small_order_surcharge, :maximum_distance, :long_delivery_surcharge)
    end
end
