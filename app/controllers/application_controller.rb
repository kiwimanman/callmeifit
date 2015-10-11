class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_admin
    raise ActionController::RoutingError, 'Not Found' unless current_user.admin?
  end

  def require_logged_in_user
    redirect_to "/auth/facebook" unless current_user.logged_in?
  end

  def current_user
    unless session[:user_id].blank?
      @current_user ||= User.where(id: session[:user_id]).first
    end
    @current_user ||= User.new
  end
  before_action :current_user

  def initialize_twilio
    @twilio_account = Twilio::REST::Client.new(ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"]).account
  end
end
