class SessionsController < ApplicationController

  def new
    render :layout => false
  end
  
  def authorize
    redirect_to Fleakr.authorization_url(:delete)
  end
  
  def create
    token = Fleakr.token_from_frob(params[:frob])
    session[:auth_token] = token.value
    
    redirect_to photos_url
  end
  
  def destroy
    reset_session
    redirect_to root_url
  end

end
