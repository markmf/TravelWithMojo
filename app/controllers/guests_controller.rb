
  class GuestsController < ApplicationController
 # before_action :set_guest, only: [:show, :index, :destroy, :new, :create]
  before_action :authenticate_user!

 


  def show
     @guest = Guest.new  
  end


  def new
    @guest = Guest.new
  end

  

  def create
    
    Rails.logger.debug guest_params.inspect
   
   

    @guest = current_user.guests.new(guest_params)




    if @guest.save
     
     
      # Send itinerary to guest
     
      experience = Experience.find_by!(id: guest_params[:exp_id])
      UserMailer.send_guest_confirmation(experience, @guest.email, @guest.first_name, current_user.email, current_user.first_name + ' ' + current_user.last_name).deliver_now 
      flash[:notice] = "Itinerary was succesfully emailed to your guest!"
    else
      
      puts "****Guest create FAILED!!!!******"
    
       
    end


   
    redirect_to root_path

  end



  def destroy

  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guest
      @guest = Guest.find(params[:id])
    end

    

    # Never trust parameters from the scary internet, only allow the white list through.
    def guest_params
      params.require(:guest).permit(:email, :first_name, :last_name, :exp_id, :user_id)
    end

end