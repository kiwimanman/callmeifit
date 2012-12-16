class PhonesController < ApplicationController
  before_filter :require_logged_in_user

  def new
    @phone = Phone.new
  end

  def create
    @phone = Phone.new(params[:phone])
    @phone.user = @logged_in_user
    if @phone.save
      redirect_to @logged_in_user
    else
      render :new
    end
  end

  def destroy
    Phone.find(params[:id]).delete
    redirect_to @logged_in_user
  end

  def verify
    redirect_to @logged_in_user
  end
end