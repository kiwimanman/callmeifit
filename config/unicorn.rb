worker_processes 2
timeout 30
preload_app true
 
before_fork do |server, worker|
	# Replace with MongoDB or whatever
	if defined?(ActiveRecord::Base)
	  ActiveRecord::Base.connection.disconnect!
		Rails.logger.info('Disconnected from ActiveRecord')
	end
						 
  sleep 1
end
							 
after_fork do |server, worker|
	# Replace with MongoDB or whatever
	if defined?(ActiveRecord::Base)
	  ActiveRecord::Base.establish_connection
		Rails.logger.info('Connected to ActiveRecord')
	end

	require 'connection_pool'

	uri = URI.parse(ENV["REDISCLOUD_URL"] || 'redis://rediscloud@localhost:6379')

	redis_params = { :host => uri.host, :port => uri.port, :password => uri.password }

	redis_pool = ConnectionPool.new(:size => 5, :timeout => 5) { Redis.new(redis_params) }

	::PHONE_VERIFICATION_QUEUE = GirlFriday::WorkQueue.new(:phone_verification, :size => 3, :store => GirlFriday::Store::Redis, :store_config => { :pool => redis_pool }) do |msg|
	  Phone.send_verification(msg)
	end

	::RESORT_UPDATE_QUEUE = GirlFriday::WorkQueue.new(:resort_update, :size => 3, :store => GirlFriday::Store::Redis, :store_config => { :pool => redis_pool }) do |msg|
	  Rails.logger.info("DEBUG: Updating resort #{msg[:resort_id]}")
	  resort = SkiResort.find(msg[:resort_id])
	  Rails.logger.info("DEBUG: Updating resort #{resort.id} from #{resort.value}")
	  resort.scrape_value!
	  Rails.logger.info("DEBUG: Updating resort #{resort.id} to #{resort.value}")
	end
end
