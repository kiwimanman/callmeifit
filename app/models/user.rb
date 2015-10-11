class User < ActiveRecord::Base
  has_many :facebook_keys
  has_many :phones
  has_many :snow_events

  def verified_phones
    phones.select(&:verified?)
  end

  def verified_phone
    phones.find(&:verified?)
  end
  alias_method :verified_phone?, :verified_phone

  def admin?
    role == 'admin'
  end

  def logged_in?
    id.present?
  end
end
