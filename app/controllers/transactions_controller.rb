class TransactionsController < ApplicationController



	def create
		experience = Experience.find_by!(slug: params[:slug])
		sale = experience.sales.create( 
				amount: experience.exp_price,
				buyer_email: current_user.email,
				seller_email: experience.user.email,
				exp_id: experience.id,
				stripe_token: params[:stripeToken])
		
		sale.currency = "USD"
		sale.process!

		if sale.finished?
			redirect_to pickup_url(uuid: sale.uuid)
			# Send a confirmation email


			puts "Entered Transactions Controller***************************************"
    		puts "Experience Name => #{experience.exp_name}"
    		puts "Sending Confirmation Email Now"
    		setting = Setting.find_by(user_id: current_user.id)
    		
      		UserMailer.send_confirmation_email(experience, current_user.email, experience.user.email, current_user.first_name).deliver_now if setting.enable_email
      		UserMailer.send_host_email(experience, current_user.first_name + current_user.last_name, experience.user.email).deliver_now 
      		send_sms(experience, current_user) if setting.enable_sms
      		send_sms_host(experience, current_user)
      		
      		flash[:notice] = "Succesfully booked experience!"
		else
			puts "Someting is wrong"
			redirect_to experience_path(experience), notice: "Unable to process Stripe payment"
		end
 	end

	def pickup
		@sale = Sale.find_by!(uuid: params[:uuid])
		@experience = @sale.experience
	end

	private

		def send_sms(experience, user)
			puts("User Contact no: #{user.contact_no}")

	      @client = Twilio::REST::Client.new
	      @client.messages.create(
	        from: '+18564223781',
	        to: user.contact_no,
	        body: "#{user.first_name}  #{user.last_name } booked your '#{experience.exp_name}'"
     	 )
   		end


		def send_sms_host(experience, user)
		  hostno = experience.user.contact_no
	      @client = Twilio::REST::Client.new
	      @client.messages.create(
	        from: '+18564223781',
	        to: hostno,
	        body: "#{user.first_name}  #{user.last_name } booked your '#{experience.exp_name}'"
     	 )
   		end


end

#token = params[:stripeToken]

#		begin
#			charge = Stripe::Charge.create(
#				amount: experience.exp_price * 100,
#              currency: "usd",
#				card: token,
#				description: current_user.email)
		

#			@sale = experience.sales.create!(buyer_email: current_user.email)
#rescue Stripe::CardError => e
#  				flash[:notice] = e.message
#  				redirect_to experience_path(experience)
# 			end
