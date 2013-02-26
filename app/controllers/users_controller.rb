class UsersController < ApplicationController
  before_filter :authorized_only, except: :index

  http_basic_authenticate_with name: ENV['HTTP_USER'], password: ENV['HTTP_PASSWORD'], only: :index

  def show
    debugger
    @user = User.find(params[:id])
  end

  def index
    @users = User.find(:all, :include => :facebook_keys)
  end

  protected

  def authorized_only
    debugger
    redirect_to @logged_in_user unless @logged_in_user.id == params[:id].to_i
  end
end