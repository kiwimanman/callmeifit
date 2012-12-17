class SnowEvent < ActiveRecord::Base
  belongs_to :user
  belongs_to :ski_resort
  belongs_to :phone
end