class PayoffsController < ApplicationController

# Display as a host all your experiences (ie events)
  def index

  
 
   
  end


  def new
 
 	@payoff = Payoff.new


  end


  def create


	Rails.logger.debug payoff_params.inspect

	@payoff = Payoff.new(payoff_params)
	
	acct = Stripe::Account.create({
			:country => @payoff.country,
			:type => "custom",
			:email => current_user.email
		
	})

	acct = Stripe::Account.retrieve(acct.id)
	acct.tos_acceptance.date = Time.now.to_i
	acct.tos_acceptance.ip = request.remote_ip # Assumes you're not using a proxy
	#acct.legal_entity.first_name_kana = @payoff.first_name_kana
	#acct.legal_entity.first_name_kanji = @payoff.first_name_kanji
	acct.legal_entity.type = 'individual'

	acct.save


	@payoff.custom_stripe_id = acct.id
	@payoff.user_id          = current_user.id
	@payoff.type             = "custom"


	puts "#{acct}"
	puts "Stripe ID: #{@payoff.custom_stripe_id}"

	respond_to do |format|
		if @payoff.save
			puts "Payoff Saved"
		#	redirect_to root_path, notice: 'Payoff Account was successfully created.' 
			format.html { redirect_to root_path, notice: 'Payoff Account was successfully created.' }
		else
			puts "Failed Payoff Save"

		end
	end


 end
	


private

# Never trust parameters from the scary internet, only allow the white list through.
    def payoff_params
      params.require(:payoff).permit(:country, :custom_stripe_id, :type, :dob_day, :dob_month, :dob_year, :gender, :phone_no, :first_name_kana, :first_name_kanji, :last_name_kana, :last_name_kanji,  :bank_name, :branch_name, :account_name_kana, :account_no, :bank_code, :branch_code )
    end

  
	
end