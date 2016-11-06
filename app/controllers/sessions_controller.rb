class SessionsController < ApplicationController
  before_action :logged_in_user, :only => [:show, :credits]

  layout 'account'
  
  def show
  end

  def credits
  end

	def new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    respond_to do |format|
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        log_in user
        remember(user)
        format.html { redirect_to account_url }
        format.js { redirect_to account_url }
      else
        format.html { render :new }
        format.js { 
          flash.now[:error] = 'Invalid email/password combination'
          render partial:'layouts/handle_flashes'
        }
      end
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
