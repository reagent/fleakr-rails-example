class SessionsController < ApplicationController

  def new; end
  
  def authorize
    redirect_to Fleakr.authorization_url(:delete)
  end
  
  def create
    token = Fleakr.token_from_frob(params[:frob])
    session[:auth_token] = token.value
    
    redirect_to photos_url
  end

end
