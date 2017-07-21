class PayoutController < ApplicationController

# Display as a host all your experiences (ie events)
  def welcome

  
    @experiences = current_user.experiences
   
  end


	
end