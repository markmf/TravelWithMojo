class HostsController < ApplicationController

	def show
		@host_id = params[:id]
		@host = User.find(@host_id)
		@host_experiences = Experience.where(user_id: @host_id)
		@host_reviews = Review.where(user_id: @host_id).order('experience_id')
		

	end



end