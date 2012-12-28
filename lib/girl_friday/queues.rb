require 'connection_pool'

uri = URI.parse(ENV["REDISCLOUD_URL"] || 'redis://rediscloud@localhost:6379')

redis_params = { :host => uri.host, :port => uri.port, :password => uri.password }
redis_params.delete(:password) if redis_params[:password].blank?

redis_pool = ConnectionPool.new(:size => 5, :timeout => 5) { Redis.new(redis_params) }

::PHONE_VERIFICATION_QUEUE = GirlFriday::WorkQueue.new(:phone_verification, :size => ENV["WORKER"] == 'true' ? 1 : 0, :store => GirlFriday::Store::Redis, :store_config => { :pool => redis_pool }) do |msg|
  Phone.send_verification(msg)
end

::RESORT_UPDATE_QUEUE = GirlFriday::WorkQueue.new(:resort_update, :size => ENV["WORKER"] == 'true' ? 1 : 0, :store => GirlFriday::Store::Redis, :store_config => { :pool => redis_pool }) do |msg|
  Rails.logger.info("DEBUG: Updating resort #{msg[:resort_id]}")
  resort = SkiResort.find(msg[:resort_id])
  Rails.logger.info("DEBUG: Updating resort #{resort.id} from #{resort.value}")
  resort.scrape_value!
  Rails.logger.info("DEBUG: Updating resort #{resort.id} to #{resort.value}")
end