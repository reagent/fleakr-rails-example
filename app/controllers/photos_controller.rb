class PhotosController < ApplicationController
  
  before_filter :check_for_flickr_user_or_redirect
  
  def index
    @photos = current_flickr_user.photos
  end

end
