class StaticPagesController < ApplicationController
  def home
  	# skip CAS authentication
  	def skip_login?
  		true
  	end


  end

  def about
  	#skip CAS authentication
  	def skip_login?
  		true
  	end

  	
  end
end
