module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  #filters
  
  def not_logged_in_user_only
    redirect_to account_url if logged_in?
  end
  
  def info_filled_in?
    !(current_user.email.blank? || current_user.phone.blank?)
  end

  def logged_in_user_and_fill_in
    redirect_to signup_url unless logged_in?
    redirect_to account_edit_url if logged_in? && !info_filled_in?
  end

  def logged_in_user
    redirect_to root_url unless logged_in?
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
  
end
