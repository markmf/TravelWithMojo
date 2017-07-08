class PhotosController < ApplicationController

	def destroy
		@photo = Photo.find(params[:id])
		experience = @photo.experience

		@photo.destroy
		@photos = Photo.where(experience_id: experience.id)

		respond_to :js
	end
end