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

    if params[:call]
      @call = @twilio_account.calls.create(
        :from => ENV['TWILIO_PHONE'],
        :to => @phone.twilio_formatted,
        :url => with_code_phones_url(:code => @phone.verification_token, :format => :xml)
      )
    else
      response = @twilio_account.sms.messages.create(
        :from => ENV['TWILIO_PHONE'],
        :to => @phone.twilio_formatted,
        :body => "Your verfication code is: #{@phone.verification_token}"
      )
    end

    redirect_to @logged_in_user
  end
end