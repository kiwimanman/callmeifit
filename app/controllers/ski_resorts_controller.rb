class SkiResortsController < ApplicationController
  def index
    @resorts = SkiResort.all
  end

  def show
    @resort = SkiResort.where(id: params[:id])
  end

  def notify
    @resort = SkiResort.where(id: params[:id])
  end

  def test
    resort = SkiResort.where(id: params[:id])
    resort.registered_event(@logged_in_user).make_contact
    redirect_to ski_resort_path(params[:id])
  end

  def update
    snow_event = SnowEvent.where(:user_id => @logged_in_user.id, :ski_resort_id => params[:id]).first
    if snow_event.blank?
      snow_event = SnowEvent.new
      snow_event.user = @logged_in_user
      snow_event.ski_resort_id = params[:id]
    end

    snow_event.threshold = params[:threshold]
    snow_event.contact_by = params[:contact_by]
    snow_event.phone_number = @logged_in_user.verified_phone.number

    flash[:notice] = "Saved successfully" if snow_event.save
    redirect_to ski_resort_path(params[:id])
  end
end
