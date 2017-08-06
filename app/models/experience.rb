class Experience < ApplicationRecord
	validates :exp_name, :exp_desc, :exp_where_be, :exp_location, :exp_provide, :exp_duration, :exp_price, :go_time, :start_date, presence: true
	
	# before_save { self.active = true }
	#mount_uploader :image, ImageUploader

	extend FriendlyId
	friendly_id :exp_name, use: :slugged
	
	belongs_to :user
	has_many :sales
	has_many :reviews
	has_many :photos
	has_many :reservations
	has_many :schedules

#	has_attached_file :image, styles: { medium: "500x500>", thumb: "200x200#" }

 

#	validates_attachment :image,  
#	content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
#	message: 'Only images (eg, jpeg, gif, png) allowed.'


	validates_numericality_of :exp_price,
		greater_than: 49, message: "Price must be at least 50 cents."

	geocoded_by :exp_where_be
    after_validation :geocode, if: ->(obj){ obj.exp_where_be.present? && obj.exp_where_be_changed? }
	
	def average_rating
    	reviews.count == 0 ? 0 : reviews.average(:rating).round(2)
  	end

	private

		def populate_email
			self.exp_email = current_user.email
		end
	
end
