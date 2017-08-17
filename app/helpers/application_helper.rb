module ApplicationHelper

  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def avatar_url(user)

		if user.profile_pic.present?
			user.profile_pic
		else
  #   "https://www.gravatar.com/avatar/#{gravatar_id}.jpg?d=identical&s=100"
      gravatar_id = Digest::MD5::hexdigest(user.email).downcase 
		  "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(current_user.email)}"
		end
  end
  
end
