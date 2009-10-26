class SetsController < ApplicationController

  before_filter :check_for_flickr_user_or_redirect
  
  def index
    @sets = current_flickr_user.sets
  end
  
  def show
    @set = Fleakr::Objects::Set.find_by_id(params[:id])
  end
  
end
