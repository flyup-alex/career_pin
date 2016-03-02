Rails.application.config.middleware.use OmniAuth::Builder do

  provider :facebook, '178864905802302', '5fcfd73fd3151e9087155531217b80e4', 
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