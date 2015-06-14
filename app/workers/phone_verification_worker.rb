class PhoneVerificationWorker
  include Sidekiq::Worker

  def perform(phone_id, method)
    Phone.send_verification(phone_id, method.to_sym)
  end
end
