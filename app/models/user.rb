class User < ActiveRecord::Base
  has_many :facebook_keys
  has_many :phones
end