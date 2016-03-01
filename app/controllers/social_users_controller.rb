class SocialUsersController < ApplicationController

  def new

  end

  def create
  	pass_token = Digest::SHA1.hexdigest([Time.now, rand].join)
  	user = SocialUser.new(social_uid: pass_token )
  	user.save
  	session[:social_user_id] = user.social_uid 
  	redirect_to social_users_show_path
  end

  def show
  	if current_social_user
  		render 'new'
  	else
  		redirect_to "http://localhost:3000/social_users/alibaba"
  	end
  end

  def destroy
  	reset_session
  	render 'new'

  end
end
