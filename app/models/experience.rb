class Experience < ApplicationRecord
	before_update :populate_email

	extend FriendlyId
	friendly_id :exp_name, use: :slugged
	
	belongs_to :user
	has_many :sales

	has_attached_file :image


	validates_attachment :image, presence: true,
	content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
	message: 'Only images (eg, jpeg, gif, png) allowed.'



	
	private

		def populate_email
			self.exp_email = current_user.email
		end
	
end
