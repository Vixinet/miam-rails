class ApplicationController < ActionController::Base
  
  require 'ext/string'
  
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  if Rails.env == "staging"
    before_filter :authenticate
  end

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.configuration.user_id && password == Rails.configuration.password 
    end
  end
end
