class HistoryController < ApplicationController
	before_action :authenticate_user!
	
# Display as a host all your experiences (ie events)
  def index
  

# select * from sales, experiences where "markjerric@gmail.com" = sales.buyer_email and experiences.id = sales.exp_id
    _status = "finished"
#    _todays_d =  Time.now.strftime("%Y-%m-%d")

 
 @experiences = Experience.find_by_sql("select * from sales s, experiences e where  '#{current_user.email}'  = s.buyer_email and e.id = s.exp_id and s.state = '#{_status}' order by e.start_date desc")
# @experiences = Experience.find_by_sql("select * from sales s, experiences e where  '#{current_user.email}'  = s.buyer_email and e.id = s.exp_id and s.state = '#{_status}' and e.start_date >= '#{_todays_d}' ")

 
  end


	
end