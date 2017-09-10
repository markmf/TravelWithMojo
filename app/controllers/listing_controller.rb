class ListingController < ApplicationController
	before_action :authenticate_user!

# Display as a host all your experiences (ie events)
  def index

  
    @experiences = current_user.experiences
   
  end

  def show

	#@experiences = Experience.find_by_sql("select * from sales s, experiences e where  '#{current_user.email}'  = s.buyer_email and e.id = s.exp_id and s.state = '#{_status}' order by e.start_date desc")

	@experiences = current_user.experiences

	@guests = User.find_by_sql("select u.*  from sales s, users u where  u.email  = s.buyer_email and #{params[:id]} = s.exp_id and s.state = 'finished' and s.start_date = '#{params[:start_date]}' order by s.created_at desc ")

  end


private
	

	

   # Never trust parameters from the scary internet, only allow the white list through.
   def guests_params
      params.permit( :id, :start_date ) 
   end
	
end