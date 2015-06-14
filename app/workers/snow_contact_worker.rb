class SnowContactWorker
  include Sidekiq::Worker

  def perform(phone_number, contact_by, resort_id)
    controller = ApplicationController.new
    client = controller.initialize_twilio
    phone = Phone.find_by_number(phone_number)
    if contact_by == :call
      @call = client.calls.create(
        from: ENV["TWILIO_PHONE"],
        to: phone.twilio_formatted,
        url: "http://www.callmeif.it/snows/#{resort_id}/notify.xml"
      )
    else
      resort = SkiResort.find(resort_id)
      client.sms.messages.create(
        from: ENV["TWILIO_PHONE"],
        to: phone.twilio_formatted,
        body: resort.contact_message
      )
    end
  end
end
