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

end