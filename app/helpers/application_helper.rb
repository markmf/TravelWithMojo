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
		gravatar_id = Digest::MD5::hexdigest(user.email).downcase 
		if user.image
			user.image
		else
#     "https://www.gravatar.com/avatar/#{gravatar_id}.jpg?d=identical&s=100"
		"https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(current_user.email)}"
		end
  end
  
end
