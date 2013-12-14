require ::File.expand_path('../config/environment', __FILE__)
require 'unicorn/oob_gc'
require 'girl_friday/server'

use Unicorn::OobGC, 5
run Rack::URLMap.new \
  "/"       => Callmeifit::Application,
  "/girl_friday" => GirlFriday::Server.new
