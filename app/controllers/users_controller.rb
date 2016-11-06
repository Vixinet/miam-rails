class UsersController < ApplicationController
  before_action :not_logged_in_user, :only => [:new]

  layout 'account'

  def new
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

  private
    def user_params
      params.require(:user).permit(:profile_picture, :email, :password, :password_confirmation, :name, :phone, :referal)
    end
end
