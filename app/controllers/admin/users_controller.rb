class Admin::UsersController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  layout 'admin'

  # GET /admin/users
  def index
    @users = User.all
  end

  # GET /admin/users/1
  def show
    Stripe.api_key =  Rails.application.secrets.stripe_api_key
    @payments = Stripe::Customer.retrieve(current_user.stripe_id).sources.all(:limit => 100, :object => "card")
  end

  # GET /admin/users/new
  def new
    @user = User.new
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User created"
      redirect_to admin_users_url
    else
      flash[:danger] = "Can't create user"
      render :new
    end
  end

  # PATCH/PUT /admin/users/1
  def update
    if user_params[:password].blank?
      params[:user].delete :password
      params[:user].delete :password_confirmation
    end
    if @user.update(user_params)
      flash[:success] = "User updated"
      redirect_to admin_users_url
    else
      flash[:danger] = "Can't update user"
      render :edit
    end
  end

  # DELETE /admin/users/1
  def destroy
    @user.destroy
    flash[:success] = "User deleted"
    redirect_to admin_users_url
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:profile_picture, :email, :password, :password_confirmation, :admin, :name, :phone, :credits, :invitation_code)
    end
end
