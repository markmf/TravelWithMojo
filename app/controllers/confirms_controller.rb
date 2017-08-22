class ConfirmsController < ApplicationController
  
	def create	
		
		@qty = params[:qty]
		@schedule = Schedule.find_by!(id: params[:slug])
		@experience = Experience.find_by!(id: params[:exp_id])
	end

  private
    def confirms_params
      params.permit(:id, :exp_id, :qty)
    end
   
end