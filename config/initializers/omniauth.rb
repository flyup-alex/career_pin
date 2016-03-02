Rails.application.config.middleware.use OmniAuth::Builder do

  provider :facebook, '183262195362573', '1b4f0ae2593c27d6092c4c7d172cc068', 
  :display => 'popup', scope: "email, user_photos, user_posts", info_fields: 'email'

end