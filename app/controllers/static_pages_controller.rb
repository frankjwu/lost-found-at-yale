class StaticPagesController < ApplicationController
	before_filter CASClient::Frameworks::Rails::Filter, :except => [:home, :about]
	before_filter :getMe

  def home
  end

  def about
  end

  def start
  	if !@me
  		redirect_to :home
  	end
  end
end
