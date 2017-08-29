class BooksController < ApplicationController
  	# before_action :get_guests, only: [:show]


  	def index
  		@final_qty = params[:qty]
	
  
  	end

  	def new
  	
  	end

	def create	
		@qty = 1
		@final_qty = 1
		@tot_amt = 0
		@schedule = Schedule.find_by!(id: params[:sched_id])
		@experience = Experience.find_by!(id: params[:exp_id])
    @cancellation = Cancellation.find_by!(id: @experience.can_policy)
		@guest = Guest.new
	end

  private
    def books_params
      params.permit(:id, :exp_id, :qty)
    end

    def get_guests

       @guests = @experience.guests
    end
   
end