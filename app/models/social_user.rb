class SocialUser < ActiveRecord::Base

	def self.find_or_create(company_name, session_token, auth)
		    user = SocialUser.where(social_uid: session_token).first || SocialUser.new
		    if auth.provider == "facebook"
		        user.facebook_token = auth.credentials.token
		        user.facebook_uid = auth.uid
		    elsif auth.provider == "twitter"
		        user.twitter_token = auth.credentials.token
		        user.twitter_secret = auth.credentials.secret
		        user.twitter_uid = auth.uid
		    end
		    user.company_name = company_name
		    user.social_uid = session_token
		    user.save!
			
	end


end

# SCHEMA - SocialUser:
#
#      t.string :facebook_token
#      t.string :twitter_token
#      t.string :twitter_secret
#      t.string :facebook_uid
#      t.string :twitter_uid
#      t.string :social_uid
	#      t.timestamps null: false