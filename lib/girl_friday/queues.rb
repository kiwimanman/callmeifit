require 'connection_pool'

redis_pool = ConnectionPool.new(:size => 1, :timeout => 5) {
  Redis.new url: ENV['REDISTOGO_URL']
}

queue_defaults = {
  :size => ENV["WORKER"] == 'true' ? 1 : 0,
  :store => GirlFriday::Store::Redis,
  :store_config => { :pool => redis_pool },
}

::PHONE_VERIFICATION_QUEUE = GirlFriday::WorkQueue.new(:phone_verification, queue_defaults) do |msg|
  Phone.send_verification(msg)
end

queue_defaults = {
  :size => ENV["WORKER"] == 'true' ? 1 : 0,
  :store => GirlFriday::Store::Redis,
  :store_config => { :pool => redis_pool },
}

::RESORT_UPDATE_QUEUE = GirlFriday::WorkQueue.new(:resort_update, queue_defaults) do |msg|
  resort = SkiResort.find(msg[:resort_id])
  resort.scrape_value!
end

queue_defaults = {
  :size => ENV["WORKER"] == 'true' ? 1 : 0,
  :store => GirlFriday::Store::Redis,
  :store_config => { :pool => redis_pool },
}

::SNOW_CONTACT_QUEUE = GirlFriday::WorkQueue.new(:snow_contact, queue_defaults) do |msg|
  controller = ApplicationController.new
  client = controller.initialize_twilio
  phone = Phone.find_by_number(msg[:phone])
  if msg[:contact_by] == :call
    @call = client.account.calls.create(
      :from => ENV['TWILIO_PHONE'],
      :to => phone.twilio_formatted,
      :url => "http://www.callmeif.it/snows/#{msg[:ski_resort]}/notify.xml"
    )
  else
    resort = SkiResort.find(msg[:ski_resort])
    client.account.sms.messages.create(
      :from => ENV['TWILIO_PHONE'],
      :to => phone.twilio_formatted,
      :body => resort.contact_message
    )
  end
end
