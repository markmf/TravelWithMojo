class ListingController < ApplicationController

# Display as a host all your experiences (ie events)
  def index

  
    @experiences = current_user.experiences
   
  end


	
end