class CompaniesController < ApplicationController

include SocialUserHelper

  def welcome
    session[:company_name] = "Wedel"
  end

  def facebook
    if current_social_user
      @graph = facebook_data(current_social_user)
      #get liked_pages -> return id's of these pages
      @pages = @graph.get_connection( "me" , 'likes',
                    {fields: ['id', 'name'], limit: 25, :offset => "#{params[:times].to_i*24}"})
    else
      redirect_to "/auth/facebook"
    end
  end

  def facebook_show
    @graph = facebook_data(current_social_user)
    @feed = @graph.get_connection( params[:id] , 'posts',
                    {
                      fields: ['message', 'id', 'from', 'type',
                                'picture','full_picture', 'object_id', 'link', 'created_time', 'updated_time', 'place', 'actions' 

                        ], limit: 20, :offset => "#{params[:times].to_i*19}"})
    @stalked_page = StalkedPage.new
  end

  def twitter
    if current_social_user && current_social_user.twitter_token
    @friends = twitter_pass.friends
    else
    redirect_to "/auth/twitter"
    end
  end
  
  def twitter_show
    @last_tweets = twitter_feed("#{params[:name]}")
    @stalked_page = StalkedPage.new

  end

  def show
  end

  def edit
  end

  def destroy
  end
end
