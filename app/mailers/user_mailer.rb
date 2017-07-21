class UserMailer < ApplicationMailer

	def welcome_email(user)
		puts "Entering user_mailer.rb file"
		puts "User email => #{user.email}"
		@user = user
		@url  =  "www.kaper.com" # generate confirmation url
		mail(to: @user.email, subject: "Welcome to Kaper!")
	end



	def send_confirmation_email(experience, buyer_email, seller_email)
		@experience = experience
		puts "Entering user_mailer.rb file, Buyer email is => #{buyer_email}"
		puts "Sending email now experience name is #{experience.exp_name}"
		puts "Sending email now to host #{seller_email}"
	
		@url  =  "www.kaper.com" # generate confirmation url
		mail(to: buyer_email, subject: "Your purchase confirmation")
		mail(to: seller_email, subject: "You guest confirmation")
	end


	def send_host_email(experience, seller_email)
		@experience = experience

		puts"Sending email to host #{seller_email}"

		@url = "www.kaper.com"
		mail(to: seller_email, subject: "You guest confirmation")
	end


end
