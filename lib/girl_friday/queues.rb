require 'connection_pool'

redis_pool = ConnectionPool.new(size: 1, timeout: 5) do
  Redis.new url: ENV['REDISTOGO_URL']
end

class QueueWork
  def self.scrape_for_resort(resort_id)
    resort = SkiResort.find(resort_id)
    resort.scrape_value!
  end
  class << self
     include ::NewRelic::Agent::Instrumentation::ControllerInstrumentation
     add_transaction_tracer :scrape_for_resort, category: :task
  end
end

queue_defaults = {
  size: ENV['WORKER'] == 'true' ? 1 : 0,
  store: GirlFriday::Store::Redis,
  store_config: { pool: redis_pool }
}

::PHONE_VERIFICATION_QUEUE = GirlFriday::WorkQueue.new(:phone_verification, queue_defaults) do |msg|
  Phone.send_verification(msg)
end

queue_defaults = {
  size: ENV['WORKER'] == 'true' ? 1 : 0,
  store: GirlFriday::Store::Redis,
  store_config: { pool: redis_pool }
}

::RESORT_UPDATE_QUEUE = GirlFriday::WorkQueue.new(:resort_update, queue_defaults) do |msg|
  QueueWork.scrape_for_resort(msg[:resort_id])
end

queue_defaults = {
  size: ENV['WORKER'] == 'true' ? 1 : 0,
  store: GirlFriday::Store::Redis,
  store_config: { pool: redis_pool }
}

::SNOW_CONTACT_QUEUE = GirlFriday::WorkQueue.new(:snow_contact, queue_defaults) do |msg|
  controller = ApplicationController.new
  client = controller.initialize_twilio
  phone = Phone.find_by_number(msg[:phone])
  if msg[:contact_by] == :call
    @call = client.calls.create(
      from: ENV['TWILIO_PHONE'],
      to: phone.twilio_formatted,
      url: "http://www.callmeif.it/snows/#{msg[:ski_resort]}/notify.xml"
    )
  else
    resort = SkiResort.find(msg[:ski_resort])
    client.sms.messages.create(
      from: ENV['TWILIO_PHONE'],
      to: phone.twilio_formatted,
      body: resort.contact_message
    )
  end
end
