class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_company!, except: [:new, :show, :create]
  
  private
  def current_social_user
    @current_social_user ||= SocialUser.find_by(social_uid: session[:social_user_id]) if session[:social_user_id]
  end
  helper_method :current_social_user, :require_social_user, :social_logged_in?

  def social_logged_in?
    !!current_social_user
  end

  def require_social_user
    if !social_logged_in?
      flash[:danger] = "You need to be logged in to see this page."
      redirect_to '/zabezpieczeniedziala'
    end
  end

end
