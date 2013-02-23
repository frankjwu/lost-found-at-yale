class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter CASClient::Frameworks::Rails::Filter, :unless => :skip_login?

protected
 
  def getMe
   @me = User.find_or_create_by_netid( session[:cas_user] )
    if !@me
      redirect_to :root
      return false
    end
  end

  def skip_login? 
    false 
  end
end
