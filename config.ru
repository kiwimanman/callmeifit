require ::File.expand_path('../config/environment', __FILE__)
require 'girl_friday/server'

run Rack::URLMap.new \
  '/'       => Callmeifit::Application,
  '/girl_friday' => GirlFriday::Server.new
