class UserMailer < ApplicationMailer

	def welcome_email(user)
		puts "Entering user_mailer.rb file"
		puts "User email => #{user.email}"
		@user = user
		@url  =  "www.syzygy.com" # generate confirmation url
		mail(to: @user.email, subject: "Confirm your SyZyGy Membership")
	end



	def send_confirmation_email(experience, buyer_email)
		@experience = experience
		puts "Entering user_mailer.rb file, Buyer email is => #{buyer_email}"
		puts "Sending email now experience name is #{experience.exp_name}"
	
		@url  =  "www.syzygy.com" # generate confirmation url
		mail(to: buyer_email, subject: "Your purchase confirmation")
	end


end
