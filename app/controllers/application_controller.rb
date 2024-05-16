class ApplicationController < ActionController::Base
  before_action :require_login
  
  private
  def logged_in?
    !!session[:user_id]
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if !!session[:user_id]
  end
  
  def require_login
    unless logged_in?
      redirect_to login_url
    end
  end
end
