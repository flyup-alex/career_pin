class SocialUsersController < ApplicationController

before_action :require_social_user, only: [ :show ]

include SocialUserHelper

  def new
  	session[:company_name] = params[:id] 
  end

  def create

  	if session[:social_user_id].nil?
  		session[:social_user_id] = Digest::SHA1.hexdigest([Time.now, rand].join)
  	end
  	@facebook_data = request.env['omniauth.auth']
  	SocialUser.find_or_create(session[:company_name], session[:social_user_id], @facebook_data)
  	if company_signed_in?
      redirect_to root_path
    else
      redirect_to timelines_path
    end
  end

  def show
  	if current_social_user.facebook_token.present? 
  		@graph = facebook_data(current_social_user)
  		@feed = @graph.get_connection( "me" , 'posts',
                    {
                      fields: ['message', 'id', 'from', 'type',
                                'picture','full_picture', 'object_id', 'link', 'created_time', 'updated_time', 'place', 'actions' 

                        ], limit: 20, :offset => "#{params[:times].to_i*2}"})
      #get liked_pages -> return id's of these pages
      @pages = @graph.get_connection( "me" , 'likes',
                    {fields: ['id'], limit: 20, :offset => "#{params[:times].to_i*2}"})
      
  	end
  	
  	if current_social_user.twitter_token.present?
  		@last_tweets = twitter_pass.user_timeline(current_social_user.twitter_uid.to_i)		
   	end

   	if !current_social_user.twitter_token.present? && !current_social_user.facebook_token.present?
   		redirect_to root_path
   	end
  end

  def destroy
    if social_logged_in? 
    	session[:social_user_id] = nil
    end
    if company_signed_in?
      redirect_to company_logout_path      
    else
      redirect_to root_path
    end
  end
end
