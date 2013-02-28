class FacebookKey < ActiveRecord::Base
  belongs_to :user

  def self.find_or_create_from_auth_hash(auth_hash)
    return if auth_hash[:uid].blank? 
    facebook_key = FacebookKey.find_or_create_by_uid(auth_hash[:uid])
    facebook_key.user ||= User.create
    facebook_key.user.name ||= auth_hash[:info]["name"]
    facebook_key.user.photo_url ||= auth_hash[:info]["image"]
    facebook_key.info = auth_hash[:info].to_json
    creds = auth_hash[:credentials]
    facebook_key.token = auth_hash[:credentials][:token]
    facebook_key.expires_at = Time.at(auth_hash[:credentials][:expires_at])
    facebook_key.extra = auth_hash[:info].to_json
    facebook_key.save
    facebook_key
  end
end