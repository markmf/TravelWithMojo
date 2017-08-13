class UserMailer < ApplicationMailer

	def welcome_email(user)
		puts "Entering user_mailer.rb file"
		puts "User email => #{user.email}"
		@user = user
		@url  =  "www.kaizen.com" # generate confirmation url
		mail(to: @user.email, subject: "Welcome to Kaizen!")
	end



	def send_confirmation_email(experience, buyer_email, seller_email, username)
		@experience = experience
		@firstname = username
		puts "Entering user_mailer.rb file, Buyer email is => #{buyer_email}"
		puts "Sending email now experience name is #{experience.exp_name}"
		puts "Sending email now to host #{seller_email}"
	
		@url  =  "www.kaizen.com" # generate confirmation url
		mail(to: buyer_email, subject: "Your purchase confirmation. Enjoy your experience! 😁")
		#mail(to: seller_email, subject: "You guest confirmation.")
	end


	def send_host_email(experience, buyer_name, seller_email)
		@experience = experience
		@buyername = buyer_name

		puts"Sending email to host #{seller_email}"

		@url = "www.kaizen.com"
		mail(to: seller_email, subject: "You guest confirmation")
	end


end
