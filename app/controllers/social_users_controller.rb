class SocialUsersController < ApplicationController

before_action :require_social_user, only: [ :show ]

include SocialUserHelper

  def new
    if !Company.where( name: params[:id] ).any? 
      redirect_to root_path
    else
    session[:company_name] = params[:id] 
    end
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
      redirect_to career_path
    end
  end

  def show 
    if current_social_user.facebook_token.present? 
  		@graph = facebook_data(current_social_user)
  		@feed = @graph.get_connection( "me" , 'posts',
                    {
                      fields: ['message', 'id', 'from', 'type',
                                'picture','full_picture', 'object_id', 'link', 'created_time', 'updated_time', 'place', 'actions' 

                        ], limit: 100, :offset => "#{params[:times].to_i*19}"})
  	end
  	
  	if current_social_user.twitter_token.present?
  		@last_tweets = twitter_pass.user_timeline(current_social_user.twitter_uid.to_i)		
   	end

   	if !current_social_user.twitter_token.present? && !current_social_user.facebook_token.present?
   		redirect_to root_path
   	end
    @pin = Pin.new
    if params[:provider] == "twitter"
     @pins = current_social_user.pins.where(provider: "twitter", company_id: nil).order(created_at: :desc)
    elsif params[:provider] == "facebook"
     @pins = current_social_user.pins.where(provider: "facebook", company_id: nil).order(created_at: :desc)
    end
  end

  def career_pins
    if session[:presence] != "byltu"
     session[:presence] = "byltu"
     special_user_statistic_key = Digest::SHA1.hexdigest([Time.now, rand].join)
     session[:special_user_statistic_key] = special_user_statistic_key
     user_stat = Stat.new(special_user_statistic_key: special_user_statistic_key )
     user_stat.views = 1
     user_stat.visited = 1
     user_stat.company_id = Company.where(name: session[:company_name]).first.id
     user_stat.save
    end
    if session[:presence] = "byltu"
     backing_user = Stat.where(special_user_statistic_key: session[:special_user_statistic_key]).first
     backing_user.views += 1
     backing_user.save
    end  

    @pins = Pin.where(company_name: session[:company_name]).order(creation_time: :desc)
    
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
