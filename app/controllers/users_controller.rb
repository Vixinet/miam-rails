class UsersController < ApplicationController
  before_action :not_logged_in_user_only, :only => [:new]
  before_action :logged_in_user, :only => [:edit, :update]
  before_action :logged_in_user_and_fill_in, :except => [:edit, :new, :create, :update]

  layout 'account'

  def new
    @user = User.new()
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      remember(@user)
      redirect_to root_url
    else
      flash[:error] = 'Un problème est survenu. Merci de controller votre saisie.'
      render :new
    end
  end

  def update 
    @user = current_user
    if @user.update(user_params)
      redirect_to root_url
    else
      flash[:error] = 'Un problème est survenu. Merci de controller votre saisie.'
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:profile_picture, :email, :password, :password_confirmation, :name, :phone, :referal)
    end
end