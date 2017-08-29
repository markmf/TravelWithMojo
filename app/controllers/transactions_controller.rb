class TransactionsController < ApplicationController




	def create
		pusher_client = Pusher::Client.new(
	        app_id: '387204',
	       	key: 'ee11638b413352bc6ebd',
	      	secret: '8ae2992e5c1cafa72d1b',
	      	cluster: 'mt1'
   		)

    	pusher_client.trigger('my-channel', 'payment', { message: "Processing payment, #{current_user.first_name}", progress: 10 })
   
    	

		experience = Experience.find_by!(slug: params[:slug])
		sched_id = params[:sched_id]
		schedule = Schedule.where("id = ? AND experience_id = ?", params[:sched_id], experience.id).first
		
		pusher_client.trigger('my-channel', 'payment', { message: "Processing your credit card info, #{current_user.first_name}", progress: 30 })

		booked_qty = params[:qty_booked].to_i
		puts "***********Booked qty: #{booked_qty}*********"
		sale = experience.sales.create( 
				amount: experience.exp_price * booked_qty,
				buyer_email: current_user.email,
				seller_email: experience.user.email,
				exp_id: experience.id,
				booked_qty: booked_qty,
				start_date: experience.start_date,
				stripe_token: params[:stripeToken])
		
		sale.currency = "USD"
		sale.process!

		

		pusher_client.trigger('my-channel', 'payment', { message: "Halfway to destination, #{current_user.first_name}", progress: 60 })

		if sale.finished?
			redirect_to pickup_url(uuid: sale.uuid)
			# Send a confirmation email


			puts "Entered Transactions Controller***************************************"
    		puts "Experience Name => #{experience.exp_name}"
    		puts "Sending Confirmation Email Now"
    		setting = Setting.find_by(user_id: current_user.id)

    		pusher_client.trigger('my-channel', 'payment', { message: "Almost done. Sending you a confirmation email, #{current_user.first_name}", progress: 80 })

# Things to do - update no_guests in Schedule table
			total_seats = schedule.no_guests + booked_qty
			schedule.update(:no_guests => total_seats)
			
    		
      		UserMailer.send_confirmation_email(experience, current_user.email, experience.user.email, current_user.first_name).deliver_now if setting.enable_email
      		UserMailer.send_host_email(experience, current_user.first_name + current_user.last_name, experience.user.email).deliver_now 
      	# Uncomment before launch
      	#	send_sms(experience, current_user) if setting.enable_sms
      	#	send_sms_host(experience, current_user)
      		
      		pusher_client.trigger('my-channel', 'payment', { message: "Thank you very much for your order, #{current_user.first_name}", progress: 100 })
      		
      		flash[:notice] = "Succesfully booked experience!"
		else
			puts "Someting is wrong"
			redirect_to experience_path(experience), notice: "Unable to process Stripe payment"
		end
 	end

	def pickup
		@sale = Sale.find_by!(uuid: params[:uuid])
		@experience = @sale.experience
		@guest = Guest.new
		
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
