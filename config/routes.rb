ActionController::Routing::Routes.draw do |map|
  
  map.with_options :controller => "sessions" do |sessions|
    sessions.login      "login", :action => "create"
    sessions.logout     "logout", :action => "destroy"
    sessions.authorize  "authorize", :action => "authorize"
    sessions.root       :action => "new"
  end

  map.resources :photos, :only => [:index]
  map.resources :sets, :only => [:index, :show]
  
end
