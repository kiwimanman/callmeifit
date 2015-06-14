Rails.application.config.middleware.use OmniAuth::Builder do
  Rails.logger.info { "FACEBOOK_KEY=#{ENV['FACEBOOK_KEY']}" }
  Rails.logger.info { "FACEBOOK_SECRET=#{ENV['FACEBOOK_SECRET']}" }

  provider :facebook,
           ENV["FACEBOOK_KEY"],
           ENV["FACEBOOK_SECRET"],
           secure_image_url: true,
           client_options: {
             site: "https://graph.facebook.com/v2.0",
             authorize_url: "https://www.facebook.com/v2.0/dialog/oauth"
           }
end
