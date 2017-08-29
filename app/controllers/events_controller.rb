class EventsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_experience, only: [:show]
	
# Display as a host all your experiences (ie events)
  def index
  

# select * from sales, experiences where "markjerric@gmail.com" = sales.buyer_email and experiences.id = sales.exp_id
    _status = "finished"
    _todays_d =  Time.now.strftime("%Y-%m-%d")

 
# @experiences = Experience.find_by_sql("select * from sales s, experiences e where  '#{current_user.email}'  = s.buyer_email and e.id = s.exp_id and s.state = '#{_status}' ")
 @experiences = Experience.find_by_sql("select * from sales s, experiences e where  '#{current_user.email}'  = s.buyer_email and e.id = s.exp_id and s.state = '#{_status}' and e.start_date >= '#{_todays_d}' order by e.start_date asc")

 #@sales = Sale.where(buyer_email: current_user.email)
 #experience = @sales[0].experience
 # @experiences = Experience.where(id: experience.id

   
  end

  def show
    @photos = @experience.photos

    #Get available dates for this selected experience
    @schedules = Schedule.where(experience_id: @experience.id).all
    logger.debug "No of schedule #{@schedules.length}"

    
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_experience
      @experience = Experience.friendly.find(params[:id])
    end
	
end