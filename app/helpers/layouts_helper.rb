
module LayoutsHelper
	def gravatar_help user
		image_tag "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(current_user.email)}", width: 30
	end
end