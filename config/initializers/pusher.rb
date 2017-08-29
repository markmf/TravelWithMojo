require 'pusher'

Pusher.app_id = ENV['PUSHER_APP_ID']
Pusher.key =  ENV['PUSHER_APP_KEY']
Pusher.secret =  ENV['PUSHER_APP_KEY']
Pusher.logger = Rails.logger
Pusher.encrypted = true
Pusher.cluster =  "mt1"