source "https://rubygems.org"

gem "rails", "~> 4.2"

gem "foreman", "~> 0.78"
gem "pg"
gem "bigdecimal"
gem "omniauth-facebook", "~> 2.0", ">= 2.0.1"
gem "nokogiri"
gem "twilio-ruby"
gem "newrelic_rpm"
gem "dotenv-rails", "~> 2.0", ">= 2.0.1"
gem "passenger", '~> 5.0'
gem 'cancancan', '~> 1.10'

# Background working
gem "redis"
gem "hiredis"
gem "sidekiq", "~> 3.3"
gem "sinatra"
gem "connection_pool"

gem "incoming"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem "sass-rails", ">= 4.0.0"
  gem "coffee-rails", ">= 4.0.0"

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem "therubyracer", "~> 0.10", platforms: :ruby

  gem "uglifier", ">= 1.0.3"
end

gem "jquery-rails"

group :test, :development do
  gem "rspec", "~> 3.3"
  gem "rspec-rails"
  gem "factory_girl_rails"
  gem "guard-rspec"
  gem "terminal-notifier-guard", "~> 1.6"
  gem "terminal-notifier", "~> 1.6", ">= 1.6.3"
  gem "rubocop", "~> 0.32"
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

gem "byebug"
gem "ruby-debug-passenger"
