class OmniauthCallbacksController < Devise::OmniauthCallbacksController

	def facebook
		@user = User.from_omniauth(request.env["omniauth.auth"])	

		if @user.persisted?
			sign_in_and_redirect @user, :event => :authentication
			set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
		else
			session["devise.facebook_data"] = request.env["omniauth.auth"]
			redirect_to new_user_registration_path
		end
	end

	def google_oauth2
	  @user = User.from_omniauth(request.env["omniauth.auth"])  

	  logger.debug "USER INFO ==>  #{@user.inspect}"

	  if @user.persisted?
	      sign_in_and_redirect @user, :event => :authentication
	      set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
	  else
	      session["devise.google_data"] = request.env["omniauth.auth"]
	      redirect_to new_user_registration_path
	  end
	end


	def twitter
	  @user = User.from_omniauth(request.env["omniauth.auth"])  

	  if @user.persisted?
	      sign_in_and_redirect @user, :event => :authentication
	      set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
	  else
	      session["devise.twitter_data"] = request.env["omniauth.auth"]
	      redirect_to new_user_registration_path
	  end
	end

	def stripe_connect
	    @user = current_user
	    auth_data = request.env["omniauth.auth"]

	    if @user.update_attributes(provider: request.env["omniauth.auth"].provider,
	                               uid: request.env["omniauth.auth"].uid,
	                               access_code: request.env["omniauth.auth"].credentials.token,
	                               publishable_key: request.env["omniauth.auth"].info.stripe_publishable_key)
	      # anything else you need to do in response..

	      # Update Payout Schedule
	        account = Stripe::Account.retrieve(@user.uid)
	        account.payouts_enabled =  true
	        #account.payout_schedule.delay_days = 1
	        #account.payout_schedule.interval = "daily"

	        #activate on Production
	        #account.save

	        logger.debug " STRIPE Account: #{account}"

	      sign_in_and_redirect @user, :event => :authentication
	      flash[:notice] = 'Stripe Account Created And Connected' if is_navigational_format?
	    else
	      session["devise.stripe_connect_data"] = request.env["omniauth.auth"]
	      redirect_to new_user_registration_url
	    end

	    logger.debug " Authorization Data: #{auth_data}"

	   
	   
		puts "ACCESS CODE: #{request.env["omniauth.auth"].credentials.token} #{@user.access_code} UID: #{@user.uid} "
  	end

	

end