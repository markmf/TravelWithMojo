
class UsersController < ApplicationController
	before_action :authenticate_user!

	def show
		 @user = User.find(params[:id])
	end
	
	def destroy
#	   # User.find(session[:user_id]).destroy   # delete user record in DB  
 		puts "****Entering Sessions/destroy - logging out"  


 		if !current_user.uid.nil? #connected to stripe
 			puts "**********Deauthorizing Stripe***************"
 			puts "UID: #{current_user.uid}"
 			puts "ACCESS_CODE: #{current_user.access_code}"
 			# Check if user connected to Stripe
 			if !session["devise.stripe_connect_data"].nil?
	 			acct = Stripe::Account.retrieve(current_user.uid)
				acct.deauthorize(ENV['STRIPE_CONNECT_CLIENT_ID'])
			end
		end

	    session[:user_id] = nil    #  session.delete :user_id
		sign_out(current_user)    
	   	redirect_to root_path 
  	end


def update_phone_number
	puts "****ENTERING update_phone_number****************"
    current_user.update_attributes(user_params)
    current_user.generate_pin
    current_user.send_pin

    redirect_to edit_user_registration_path, notice: "Saved..."
rescue Exception => e
	redirect_to edit_user_registration_path, alert: "#{e.message}"
end

def verify_phone_number
	current_user.verify_pin(params[:user][:pin])

	if current_user.phone_verified
	  flash[:notice] = "Your phone number is verified."
	else
	  flash[:alert] = "Cannot verify your phone number."
	end

	redirect_to edit_user_registration_path

rescue Exception => e
redirect_to edit_user_registration_path, alert: "#{e.message}"
end



  private

    def user_params
      params.require(:user).permit(:contact_no, :pin)
    end

end