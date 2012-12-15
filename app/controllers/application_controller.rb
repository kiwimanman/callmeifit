class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :logged_in_user

  def logged_in_user
    @user = User.find(session[:user_id]) unless session[:user_id].blank?
  end
end
