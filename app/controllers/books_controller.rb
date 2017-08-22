class BooksController < ApplicationController
  
  	def index
  		@final_qty = params[:qty]
		tot_amt = params[:tot_amt]

  
  	end

	def create	
		@qty = 1
		@final_qty = 1
		@tot_amt = 0
		@schedule = Schedule.find_by!(id: params[:sched_id])
		@experience = Experience.find_by!(id: params[:exp_id])
		
		
		
	end

  private
    def books_params
      params.permit(:id, :exp_id, :qty, :tot_amt)
    end
   
end