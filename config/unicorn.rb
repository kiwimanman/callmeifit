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
		config = Rails.application.config.database_configuration[Rails.env]
    config['reaping_frequency'] = ENV['DB_REAP_FREQ'] || 10 # seconds
    config['pool']              = ENV['DB_POOL'] || 5
	  ActiveRecord::Base.establish_connection(config)
		Rails.logger.info('Connected to ActiveRecord')
	end

	require 'girl_friday/queues'
	GirlFriday.begin_polling
end
