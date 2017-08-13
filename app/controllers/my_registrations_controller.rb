class MyRegistrationsController < Devise::RegistrationsController

  respond_to :json
  
  def create
    super
    if @user.persisted?
    	puts "Entered MyREgistratonsController***************************************"
    	puts "User email => #{@user.email}"
      	UserMailer.welcome_email(@user).deliver_now
    end

    
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



  protected
	def update_resource(resource, params)
		resource.update_without_password(params)
	end

end