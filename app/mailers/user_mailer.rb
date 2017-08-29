class UserMailer < ApplicationMailer


	require 'open-uri'

	def welcome_email(user)
		puts "Entering user_mailer.rb file"
		puts "User email => #{user.email}"
		@user = user
		@url  =  "www.zenzen.com" # generate confirmation url
		mail(to: @user.email, subject: "Thanks for signing up")
	end



	def send_confirmation_email(experience, buyer_email, seller_email, username)
		

		@experience = experience
		@firstname = username
		@filename = "https:" + "#{@experience.photos[0].image.url}"
		
	
	
	#	attachments.inline["image_file_name"] = File.read("#{@experience.photos[0].image.url(:thumb)}")
	#	attachments.inline["0"] = File.open(@filename, "rb")  {|io| io.read}


		
		attachments.inline["file"] = {	
			:data => open(@filename)  {|f| f.read },
			:mime_type => "image/png",
			:encoding => "base64"

		}

		puts "filename ==> #{@filename}****************"
	

		puts "Entering user_mailer.rb file, Buyer email is => #{buyer_email}"
		puts "Sending email now experience name is #{experience.exp_name}"
		puts "Sending email now to host #{seller_email}"
	


		@url  =  "www.zenzen.com" # generate confirmation url
		mail(to: buyer_email, subject: "Your booking confirmation for #{@experience.exp_name}. Enjoy your experience! 😁")
		#mail(to: seller_email, subject: "You guest confirmation.")
	end

	def send_guest_confirmation(experience, guest_email, guest_name, sender_email, sender_name )
		@experience = experience
		@firstname = guest_name

		puts "Confirmation sent to #{guest_name}"
		mail(to: guest_email, subject: "A copy of this confirmation has been emailed to you by #{sender_name}. Enjoy your experience! 😁")
		
	end


	def send_host_email(experience, buyer_name, seller_email)
		@experience = experience
		@buyername = buyer_name

		puts"Sending email to host #{seller_email}"

		@url = "www.kaizen.com"
		mail(to: seller_email, subject: "You guest confirmation")
	end


end
