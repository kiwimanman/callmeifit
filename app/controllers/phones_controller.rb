class PhonesController < ApplicationController
  before_filter :require_logged_in_user, :except => :with_code
  before_filter :initialize_twilio, :only => :verify

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
    @phone = Phone.find(params[:id])
    @phone.generate_verification_token
    @phone.save
    
    PHONE_VERIFICATION_QUEUE.push(:method => (params[:call] ? :call : :sms), :phone_id => @phone.id)

    redirect_to @logged_in_user
  end

  def confirm
    @phone = Phone.find(params[:id])
    if @phone.verifation_confirmed? params[:code]
      @phone.save
      redirect_to @logged_in_user
    else
      flash[:code_confirm_error] = true
    end
  end
end