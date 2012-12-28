require 'connection_pool'

redis_pool = ConnectionPool.new(:size => 5, :timeout => 5) {
  Redis.new url: (ENV['MYREDIS_URL'] || 'redis://rediscloud@localhost:6379')
}

queue_defaults = {
  :size => ENV["WORKER"] == 'true' ? 1 : 0,
  :store => GirlFriday::Store::Redis,
  :store_config => { :pool => redis_pool }
}

::PHONE_VERIFICATION_QUEUE = GirlFriday::WorkQueue.new(:phone_verification, queue_defaults) do |msg|
  Phone.send_verification(msg)
end

::RESORT_UPDATE_QUEUE = GirlFriday::WorkQueue.new(:resort_update, queue_defaults) do |msg|
  Rails.logger.info("DEBUG: Updating resort #{msg[:resort_id]}")
  resort = SkiResort.find(msg[:resort_id])
  Rails.logger.info("DEBUG: Updating resort #{resort.id} from #{resort.value}")
  resort.scrape_value!
  Rails.logger.info("DEBUG: Updating resort #{resort.id} to #{resort.value}")
end