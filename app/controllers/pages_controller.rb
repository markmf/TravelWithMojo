class PagesController < ApplicationController
  
  def home
  	if current_user
  		redirect_to experiences_path

  	end

  	@experiences = Experience.all
  end
end
