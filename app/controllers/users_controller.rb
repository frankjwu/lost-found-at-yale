# authentication logic
 
  def login
    if session[:current_user] # already logged in
      redirect_to '/'
    elsif session[:cas_user]
      user = User.find_or_create_by_netid( session[:cas_user] )
      if user.netid && user.email # reject if we can't find an email
        session[:current_user] = user
        redirect_to '/'
      else
        redirect_to '/splash'
      end
    else # default
      redirect_to '/splash'
    end
  end