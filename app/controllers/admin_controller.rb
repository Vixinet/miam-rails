class AdminController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user

  def home
  	@opt_ins = OptIn.group('date(created_at)').count(:email)
    render 'home'
  end

end
