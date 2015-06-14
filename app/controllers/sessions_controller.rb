class SessionsController < ApplicationController
  def create
    facebook_key = FacebookKey.find_or_create_from_auth_hash(auth_hash)
    session[:user_id] = facebook_key.user.id if facebook_key

    redirect_to ski_resorts_path
  end

  def logout
    session[:user_id] = nil
    redirect_to ski_resorts_path
  end

  protected

  def auth_hash
    request.env["omniauth.auth"]
  end
end
