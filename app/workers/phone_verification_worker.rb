class PhoneVerificationWorker
  include Sidekiq::Worker

  def perform(msg)
    Phone.send_verification(msg)
  end
end
