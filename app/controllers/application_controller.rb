# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details


  protected
  def current_flickr_user
    Fleakr.user_for_token(session[:auth_token]) unless session[:auth_token].nil?
  end
  
  def check_for_flickr_user_or_redirect
    redirect_to root_url and return if current_flickr_user.nil?
  end

end
