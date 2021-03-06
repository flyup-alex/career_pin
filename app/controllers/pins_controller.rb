class PinsController < ApplicationController
  
include SocialUserHelper

  def career_pin_outside
    if session[:candidate] != "widziałemto"
     session[:candidate] = "widziałemto"
     special_user_statistic_key = Digest::SHA1.hexdigest([Time.now, rand].join)
     session[:special_user_statistic_key] = special_user_statistic_key
     user_stat = Stat.new(special_user_statistic_key: special_user_statistic_key )
     user_stat.views = 1
     user_stat.visited = 1
     user_stat.career_pin = true
     user_stat.company_id = Company.where(name: params[:company_name]).first.id
     user_stat.save
    end
    if session[:candidate] = "widziałemto"
     backing_user = Stat.where(special_user_statistic_key: session[:special_user_statistic_key]).first
     backing_user.views += 1
     backing_user.save
    end  
    @pins = Pin.where(company_name: params[:company_name], career_pin: true).order(creation_time: :desc).first(20)
  end

  def create
  	@pin = Pin.new(super_params)
  	if @pin.save
  		redirect_to :back
  	else
  		redirect_to root_path
  	end 
    flash[:success] = "New pin was added!"
    flash[:notice] = "You have added new pin to internal career-pin for your coworkers. Good Job!"
  end

  def twitter_create
    @last_tweets = twitter_feed( params[:name] )
    author_photo = @last_tweets.first.user.profile_image_uri(size = :normal)
    user_name = @last_tweets.first.user.name
    screen_name = @last_tweets.first.user.screen_name
      @last_tweets.each do |tweet|
       pin = Pin.new
       pin.author_image = author_photo
       pin.link = tweet.uri
       pin.provider = "twitter"
       pin.image = tweet.media[0]["media_url"] if tweet.media.present?
       pin.author_name = user_name
       pin.message = tweet.text
       pin.creation_time = tweet.created_at
       pin.social_user_id = current_social_user.id
       pin.company_id = current_company.id if current_company
       pin.company_name = session[:company_name]
       pin.career_pin = true
       pin.save
      end
    if params[:career_pin] == "true"
     redirect_to step_by_step_path(step: "3", provider: "twitter")
    else
     redirect_to :back
    end
  end

  def facebook_create
    @graph = facebook_data(current_social_user)
    @feed = @graph.get_connection( params[:id] , 'posts',
                    {
                      fields: ['message', 'id', 'from', 'type',
                                'picture','full_picture', 'object_id', 'link', 'created_time', 'updated_time', 'place', 'actions' 

                        ], limit: 20, :offset => "#{params[:times].to_i*19}"})
    author_photo = @graph.get_picture(@feed.first['from']['id'], type: :large)
    user_name = @feed.first['from']['name']
    @feed.each do |post|
       pin = Pin.new
       pin.author_image = author_photo
       pin.link = "http://facebook.com/#{post['id']}"
       pin.provider = "facebook"
       pin.image = post['full_picture']
       pin.author_name = user_name
       pin.message = post['message'] if post['message']
       pin.creation_time = post['updated_time']
       pin.social_user_id = current_social_user.id
       pin.company_id = current_company.id if current_company
       pin.company_name = session[:company_name]
       pin.career_pin = true
       pin.save
      end
    if params[:career_pin] == "true"
     redirect_to step_by_step_path(step: "3", provider: "facebook")
    else
     redirect_to :back
    end
  end

  def destroy
    @pin = Pin.find(params[:id])
    if @pin.destroy
      redirect_to :back
    else
      redirect_to career_path
    end 

  flash[:danger] = "Pin was deleted!"
  flash[:notice] = "Pin was removed from all career-pins. Now nobody is able to see it."

  end


  def new
  end

  private

  def super_params

  	params.require(:pin).permit(:author_image, :link, :provider, :image, :author_name, :message, :creation_time, :social_user_id, :company_id, :company_name)
  	
  end
end
