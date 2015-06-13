class PhonesController < ApplicationController
  before_filter :require_logged_in_user, except: :with_code

  def new
    @phone = Phone.new
  end

  def create
    @phone = Phone.new(params.require(:phone).permit(:number))
    @phone.user = logged_in_user
    if @phone.save
      redirect_to user_path
    else
      render :new
    end
  end

  def destroy
    Phone.where(id: params[:id]).each(&:delete)
    redirect_to @logged_in_user
  end

  def verify
    @phone = Phone.where(id: params[:id]).first
    @phone.generate_verification_token
    @phone.save

    msg = { method: (params[:call] ? :call : :sms), phone_id: @phone.id }
    PhoneVerificationWorker.perform_async(msg)

    redirect_to @logged_in_user
  end

  def confirm
    @phone = Phone.where(id: params[:id]).first
    if @phone.verifation_confirmed? params[:code]
      @phone.save
      redirect_to @logged_in_user
    else
      flash[:code_confirm_error] = true
    end
  end
end
