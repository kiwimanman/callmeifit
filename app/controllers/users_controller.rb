class UsersController < ApplicationController
  before_filter :authorized_only

  def show
    @user = User.find(params[:id])
  end

  protected

  def authorized_only
    redirect_to @logged_in_user unless @logged_in_user.id == params[:id].to_i
  end
end