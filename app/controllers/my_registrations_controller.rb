class MyRegistrationsController < Devise::RegistrationsController

  def create
    super
    if @user.persisted?
    	puts "Entered MyREgistratonsController***************************************"
    	puts "User email => #{@user.email}"
      	UserMailer.welcome_email(@user).deliver_later
    end
  end

end