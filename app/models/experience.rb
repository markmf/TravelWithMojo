class Experience < ApplicationRecord
	validates :exp_name, :exp_desc, :exp_where_be, :exp_location, :exp_provide, :exp_duration, presence: true
	
	

	extend FriendlyId
	friendly_id :exp_name, use: :slugged
	
	belongs_to :user
	has_many :sales
	has_many :reviews

	has_attached_file :image, styles: { medium: "500x500>", thumb: "200x200>" }

 

	validates_attachment :image, presence: true, 
#	styles: { medium: "400x400#", thumb: "200x200#" },
	content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
	message: 'Only images (eg, jpeg, gif, png) allowed.'


	validates_numericality_of :exp_price,
		greater_than: 49, message: "Price must be at least 50 cents."

	geocoded_by :exp_where_be
    after_validation :geocode, if: ->(obj){ obj.exp_where_be.present? && obj.exp_where_be_changed? }
	
	

	private

		def populate_email
			self.exp_email = current_user.email
		end
	
end
