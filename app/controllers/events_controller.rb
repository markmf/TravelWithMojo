class EventsController < ApplicationController

# Display as a host all your experiences (ie events)
  def index
  

# select * from sales, experiences where "markjerric@gmail.com" = sales.buyer_email and experiences.id = sales.exp_id
    _status = "finished"
 
 	@experiences = Experience.find_by_sql("select * from sales s, experiences e where  '#{current_user.email}'  = s.buyer_email and e.id = s.exp_id and s.state = '#{_status}' ")
 
 #@sales = Sale.where(buyer_email: current_user.email)
 #experience = @sales[0].experience
 # @experiences = Experience.where(id: experience.id

   
  end


	
end