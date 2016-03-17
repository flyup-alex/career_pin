class CompaniesController < ApplicationController

include SocialUserHelper

  def welcome
    session[:company_name] = current_company.name
    if !current_company.pins.present? 
      redirect_to step_by_step_path(step: 1) 
    end
    # How many people from your company seen inside version of career-pin #
    
    @views = 0
    current_company.stats.where(["updated_at > ?", 7.days.ago]).where(career_pin: false).each do |stat|
      @views += stat.views.to_i
    end

    
    # end #

    # How many people from your company visited career-pin - uniqueness workers #
    @visited = 0
    current_company.stats.all.each do |stat|
     @visited += stat.visited.to_i
    end



    @pins = Pin.where(company_name: current_company.name ).order(creation_time: :desc)

  end

  def facebook
    if current_social_user
      @graph = facebook_data(current_social_user)
      #get liked_pages -> return id's of these pages
      @pages = @graph.get_connection( "me" , 'likes',
                    {fields: ['id', 'name'], limit: 20, :offset => "#{params[:times].to_i*19}"})
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
    user = current_social_user
    @pin = Pin.new
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
    @pin = Pin.new
  end

  def career_pin_admin
    # How many people from your company seen inside version of career-pin #
    
    @views = 0
    current_company.stats.where(["updated_at > ?", 7.days.ago]).where(career_pin: true).each do |stat|
      @views += stat.views.to_i
    end

    
    # end #

    # How many people from your company visited career-pin - uniqueness workers #
    @visited = 0
    current_company.stats.where(career_pin: true).each do |stat|
     @visited += stat.visited.to_i
    end

    @pins = Pin.where(company_name: current_company.name, career_pin: true).order(creation_time: :desc).first(20)
    
  end

  def add_to_career_pin_outside

    @pin = Pin.find(params[:id])
    @pin.career_pin = true
    @pin.save
    redirect_to :back

    flash[:success] = "Successfuly added"
    flash[:notice] = "Pin was successfuly added to career-pin and now can be seen by candidates!"
  end 


  def step_by_step
    
  end


end
