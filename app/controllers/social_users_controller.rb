class SocialUsersController < ApplicationController

  def new
  	session[:company_name] = params[:id] 
  end

  def create
  	if session[:social_user_id].nil?
  		session[:social_user_id] = Digest::SHA1.hexdigest([Time.now, rand].join)
  	end
  	@facebook_data = request.env['omniauth.auth']
  	SocialUser.find_or_create(session[:company_name], session[:social_user_id], @facebook_data)
  	redirect_to root_path
  end

  def show
  	current_social_user
  end

  def destroy
  	SocialUser.find_by(social_uid: current_social_user.social_uid).destroy
  	session[:social_user_id] = nil

  	redirect_to root_path
  end
end
