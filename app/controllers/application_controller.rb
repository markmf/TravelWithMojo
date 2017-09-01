class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :run_cronjob

  rescue_from CanCan::AccessDenied do  |exception|
  	redirect_to root_path, notice: "You are not authorized to access this page."
  end

  protected


  def configure_permitted_parameters
  
  	devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name ])
  	devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :name, :contact_no, :email, :description, :image, :profile_pic])
  	
   
  end


  def run_cronjob


  # Enqueue a job to be performed as soon as the queuing system is
  # free.
  # running the cron job that will notify users if they have an event 2 days from now
  # EventNotificationJob.perform_later

  # Uncomment this
  # Enqueue a job to be performed today at noon.
   EventNotificationJob.set(wait_until: Date.today.noon).perform_later


  end

end
