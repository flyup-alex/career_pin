module SocialUserHelper

def facebook_data(user)
	Koala.config.api_version = "v2.1"
	@graph = Koala::Facebook::API.new( user.facebook_token )
end

def twitter_pass
    @tweet = Twitter::REST::Client.new do |config|
    config.consumer_key        = "LG74yEHe81rppMoq665Fbee8S"
    config.consumer_secret     = "theOlCPDQYydrg8uTwcHPT9yNk4LZxOR8ijGZf3dQ7sam2w80H"
    config.access_token        = "#{current_social_user.twitter_token}"
    config.access_token_secret = "#{current_social_user.twitter_secret}"
    end
end

def twitter_feed(profile) 
 		@tweet = Twitter::REST::Client.new do |config|
        config.consumer_key        = "LG74yEHe81rppMoq665Fbee8S"
        config.consumer_secret     = "theOlCPDQYydrg8uTwcHPT9yNk4LZxOR8ijGZf3dQ7sam2w80H"
        config.access_token        = "#{current_social_user.twitter_token}"
        config.access_token_secret = "#{current_social_user.twitter_secret}"
  		end	
 		@tweet.user_timeline( "#{profile}", options={count: 100} ) #limits array to 10 items
end

end
