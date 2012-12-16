class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :logged_in_user

  def logged_in_user
    @logged_in_user = User.find(session[:user_id]) unless session[:user_id].blank?
  end

  def require_logged_in_user
    redirect_to login_path if session[:user_id].blank?
  end
end
