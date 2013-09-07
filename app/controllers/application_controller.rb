class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :logged_in_user

  include ApplicationHelper

  def require_logged_in_user
    redirect_to '/auth/facebook' unless logged_in_user
  end

  def initialize_twilio
    @twilio_account = Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV['TWILIO_TOKEN']).account
  end
end
