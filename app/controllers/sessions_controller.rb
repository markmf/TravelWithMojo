
class SessionsController < Devise::SessionsController 


    respond_to :json



	def destroy
#	   # User.find(session[:user_id]).destroy   # delete user record in DB  
 		puts "****Entering Sessions/destroy - logging out"  


 		if !current_user.uid.nil? #connected to stripe
 			puts "**********Deauthorizing Stripe***************"
 			puts "UID: #{current_user.uid}"
 			puts "ACCESS_CODE: #{current_user.access_code}"
 			if !session["devise.stripe_connect_data"].nil?
	 			acct = Stripe::Account.retrieve(current_user.uid)
				acct.deauthorize(ENV['STRIPE_CONNECT_CLIENT_ID'])
			end
		end

	    session[:user_id] = nil    #  session.delete :user_id
		sign_out(current_user)    
	   	redirect_to root_path 
  	end 

end