class SetsController < ApplicationController
  
  def index
    @sets = current_flickr_user.sets
  end
  
  def show
    @set = Fleakr::Objects::Set.find_by_id(params[:id])
  end
  
end
