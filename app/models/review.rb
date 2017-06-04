class Review < ApplicationRecord

	belongs_to :experience
	belongs_to :sale

	has_many   :user

end
