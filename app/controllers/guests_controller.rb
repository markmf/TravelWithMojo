class GuestsController < ApplicationController
  before_action :set_guest, only: [:show, :index, :destroy, :new, :create]


  def index 
    @guests = Guest.all
  end


  def show
  end


  def new
    @guest = Guest.new  
  end

  

  def create
    
    Rails.logger.debug guest_params.inspect
   
   # @experience = Experience.friendly.find(params[:id])
    @guest = current_user.guests.create(guest_params)


    if @guest.save
      puts "*****Guest was succesfully created!"
     
    else

      puts "****Guest create FAILED!!!!******"
     
    end

 
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
      params.require(:guest).permit(:email, :first_name, :last_name, :exp_id)
    end
end