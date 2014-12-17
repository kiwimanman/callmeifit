source 'https://rubygems.org'

ruby '2.1.2'

gem 'rails', '~> 4.0.0'

gem 'foreman'
gem 'pg'
gem 'bigdecimal'
gem 'omniauth-facebook'
gem 'nokogiri'
gem 'twilio-ruby'
gem 'newrelic_rpm'

# Background working
gem 'redis'
gem 'hiredis'
gem 'girl_friday', :git => 'git://github.com/kiwimanman/girl_friday.git'
gem 'sinatra'
gem 'connection_pool'

gem 'incoming'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '>= 4.0.0'
	gem 'coffee-rails', '>= 4.0.0'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', '~> 0.10', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :test, :development do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'guard-rspec'
  gem 'terminal-notifier-guard'
end

gem 'capistrano', '~> 3.1.0'
gem 'capistrano-bundler', '~> 1.1.2'
gem 'capistrano-rails', '~> 1.1.1'
gem 'capistrano-rbenv', github: "capistrano/rbenv"

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
gem 'unicorn'
gem 'byebug'
