class UserMailer < ApplicationMailer

	def welcome_email(user)
		puts "Entering user_mailer.rb file"
		puts "User email => #{user.email}"
		@user = user
		@url  =  "www.kaper.com" # generate confirmation url
		mail(to: @user.email, subject: "Welcome to Kaper.com")
	end



	def send_confirmation_email(experience, buyer_email)
		@experience = experience
		puts "Entering user_mailer.rb file, Buyer email is => #{buyer_email}"
		puts "Sending email now experience name is #{experience.exp_name}"
	
		@url  =  "www.kaper.com" # generate confirmation url
		mail(to: buyer_email, subject: "Your purchase confirmation")
	end


end
