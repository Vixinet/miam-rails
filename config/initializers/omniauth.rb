OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Rails.application.secrets.facebook_app_id, Rails.application.secrets.facebook_app_secret, :secure_image_url => true,
	:scope => 'email', :display => 'popup', :info_fields => 'name,email'
end

