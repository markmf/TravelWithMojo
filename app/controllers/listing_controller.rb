class ListingController < ApplicationController
	before_action :authenticate_user!

# Display as a host all your experiences (ie events)
  def index

  
    @experiences = current_user.experiences
   
  end


	
end