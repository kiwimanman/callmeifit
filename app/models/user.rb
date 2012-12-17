class User < ActiveRecord::Base
  has_many :facebook_keys
  has_many :phones
  has_many :snow_events

  def verified_phones
    phones.select{ |phone| phone.verified? }
  end

  def verified_phone
    phones.find{ |phone| phone.verified? }
  end
  alias_method :verifed_phone?, :verified_phone

end