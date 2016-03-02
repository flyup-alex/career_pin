Rails.application.config.middleware.use OmniAuth::Builder do

  provider :facebook, '183262195362573', '1b4f0ae2593c27d6092c4c7d172cc068', 
  :display => 'popup', scope: "email, user_photos, user_posts", info_fields: 'email'

  provider :twitter, 'LG74yEHe81rppMoq665Fbee8S', 'theOlCPDQYydrg8uTwcHPT9yNk4LZxOR8ijGZf3dQ7sam2w80H',
					    {
					      :secure_image_url => 'true',
					      :image_size => 'original',
					      :authorize_params => {
					        :force_login => 'true',
					        :lang => 'pt'
					      }
					    }

end