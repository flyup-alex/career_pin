module SocialUserHelper

def facebook_data(user)
	Koala.config.api_version = "v2.1"
	@graph = Koala::Facebook::API.new( user.facebook_token )
end


end
