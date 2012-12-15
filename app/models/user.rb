class User < ActiveRecord::Base
  has_many :facebook_keys
end