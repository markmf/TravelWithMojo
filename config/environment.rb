# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.delivery_method = :smtp
#ActionMailer::Base.smtp_settings = {
#   :tls => true,
#   :address => "smtp.gmail.com",
#   :port => 587,
#   :domain => "smtp.gmail.com",
#   :authentication => :login,
#   :user_name => ENV["GMAIL_USERNAME"],
#   :password => ENV["GMAIL_PASSWORD"]
# }

