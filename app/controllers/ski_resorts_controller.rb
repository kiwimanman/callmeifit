class SkiResortsController < ApplicationController
  def index
    @resorts = SkiResort.all
  end

  def show
    @resort = SkiResort.find(params[:id])
  end

  def notify
    @resort = SkiResort.find(params[:id])
  end

  def update
    snow_event = SnowEvent.where(:user_id => @logged_in_user.id, :ski_resort_id => params[:id]).first
    if snow_event.blank?
      snow_event = SnowEvent.new
      snow_event.user = @logged_in_user
      snow_event.ski_resort_id = params[:id]
    end

    snow_event.threshold = params[:threshold]
    snow_event.phone_number = @logged_in_user.verified_phone.number

    if snow_event.save
      redirect_to ski_resort_path(params[:id])
    else
      render :edit
    end
  end
end
