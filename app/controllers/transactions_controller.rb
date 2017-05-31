class TransactionsController < ApplicationController


	def create
		experience = Experience.find_by!(slug: params[:slug])
		sale = experience.sales.create( 
				amount: experience.exp_price,
				buyer_email: current_user.email,
				seller_email: experience.user.email,
				stripe_token: params[:stripeToken])
		
		sale.currency = "USD"
		sale.process!

		if sale.finished?
			redirect_to pickup_url(uuid: sale.uuid)
		else
			redirect_to experience_path(experience), notice: e.message
		end
 	end

	def pickup
		@sale = Sale.find_by!(uuid: params[:uuid])
		@experience = @sale.experience
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
