class Review < ApplicationRecord
	validates :rating, :rating_desc, presence: true

	belongs_to :user
	belongs_to :experience
#	belongs_to :sale

end
