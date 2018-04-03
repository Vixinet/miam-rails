class OrdersController < ApplicationController
  before_action :logged_in_user_and_fill_in
  before_action :set_order, only: [:show]

  # GET /orders
  def index
    @orders = current_user.orders
  end

  # GET /orders/1
  def show
  end

  # POST /orders
  def confirmation
    puts "*********************************************************************************************************"
    puts order_params
    puts order_params.inspect
    puts "*********************************************************************************************************"
    
  end

  def create
    @order = Order.new()

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:venue_id, :products, :address, :)
    end
end
