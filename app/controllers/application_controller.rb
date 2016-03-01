class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def current_social_user
    @current_social_user ||= SocialUser.find_by(social_uid: session[:social_user_id]) if session[:social_user_id]
  end
  helper_method :current_social_user
end
