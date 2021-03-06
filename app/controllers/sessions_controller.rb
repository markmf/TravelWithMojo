
class SessionsController < Devise::SessionsController 


    respond_to :json

    def create

    	super
    	if current_user 
      		flash[:info] = "Welcome, #{current_user.first_name}!"
    	end

    end



	def destroy
#	   # User.find(session[:user_id]).destroy   # delete user record in DB  
 		puts "****Entering Sessions/destroy - logging out"  

 		flash[:info] = "#{current_user.first_name}, thanks for using EyeForWonder. Have a great day!"
 		#flash[:alert] = "Have a great day!"
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






end