require 'pusher'

Pusher.app_id = '387204'
Pusher.key = 'ee11638b413352bc6ebd'
Pusher.secret = '8ae2992e5c1cafa72d1b'
Pusher.logger = Rails.logger
Pusher.encrypted = true
Pusher.cluster =  "mt1"