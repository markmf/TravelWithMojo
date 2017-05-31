class TransactionsController < ApplicationController


	def create
		experience = Experience.find_by!(slug: params[:slug])
		token = params[:stripeToken]

		begin
			charge = Stripe::Charge.create(
				amount: experience.exp_price * 100,
				currency: "usd",
				card: token,
				description: current_user.email)
		

			@sale = experience.sales.create!(buyer_email: current_user.email)
				redirect_to pickup_url(uuid: @sale.uuid)


			rescue Stripe::CardError => e
  				flash[:notice] = e.message
  				redirect_to experience_path(experience)
  			end
 	end

	def pickup
		@sale = Sale.find_by!(uuid: params[:uuid])
		@experience = @sale.experience
	end

end