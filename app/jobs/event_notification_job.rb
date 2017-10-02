class EventNotificationJob < ApplicationJob
  queue_as :default

# Uncomment after debugging is completed

#  rescue_from(ActiveRecord::RecordNotFound) do |exception|
    # Do something with the exception
#  end

  def perform(*args)
    # Do something later
    puts "******* RUNNING EventNotificationJOB ****************************"

    _status = "finished"
    _2days = (Time.now + 2.days)
    _days = _2days.strftime("%Y-%m-%d")
    

  
 # select s.id, s.exp_id, s.buyer_email, u.first_name, u.last_name, e.exp_name, e.start_date, e.exp_location, e.go_time  from users u, sales s, experiences e where  u.email = s.buyer_email  and e.id = s.exp_id and s.state = 'finished' and e.start_date = "2017-09-01"  order by e.start_date asc;

 	@events_tomail = Experience.find_by_sql("select s.id, s.exp_id, s.buyer_email, u.first_name, u.last_name, e.exp_name, e.start_date, e.exp_location, e.go_time  from users u, sales s, experiences e where  u.email = s.buyer_email and e.id = s.exp_id and s.state = '#{_status}' and e.start_date = '#{_days}' and s.notified = 'f' order by e.start_date asc")

    puts "**********Email to be sent today count: #{@events_tomail.count}*******"
# loop through the results and send an email to each user
# @events_tomail.each { |e| NewsletterMailer.deliver_text_to_email(text, e) }
 @events_tomail.each { |e| UserMailer.send_event_notification(e.exp_name, e.buyer_email, e.first_name).deliver_now }

 #update notified attribute to True so it no need to send a notificaiton email
 @events_tomail.each { |e| Sale.where(id: e.id).update_all(notified: true) }


# 	DEBUG

  end


end
