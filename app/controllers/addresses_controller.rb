class AddressesController < ApplicationController
  before_action :logged_in_user
  before_action :set_address, only: [:edit, :update, :destroy, :default]

  layout 'account'

  # def default 
  #   if( @address.user_id == current_user.id )
  #     @address.status = :deleted
  #     @address.save
  #     redirect_to addresses_url
  #   end
  # end

  # GET /addresses
  def index
    @addresses = current_user.shown_addresses
  end

  # GET /addresses/new
  def new
    @address = Address.new()
  end

  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses
  def create
    @address = Address.new(address_params)
    @address.user_id = current_user.id

    if @address.save
      flash[:info] = 'Address ajoutée!'
      redirect_to addresses_url
    else
      flash[:error] = 'Un problème est survenu. Merci de controller votre saisie.'
      render :new
    end

  end

  # PATCH/PUT /addresses/1
  def update
    if @address.update(address_params)
      flash[:info] = 'Address éditée!'
      redirect_to addresses_url
    else
      flash[:error] = 'Un problème est survenu. Merci de controller votre saisie.'
      render :edit
    end
  end

  # DELETE /addresses/1
  def destroy
    if( @address.user_id == current_user.id )
      @address.status = :deleted
      @address.save
      redirect_to addresses_url
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def address_params
      params.require(:address).permit(:street, :city, :comment)
    end
end
