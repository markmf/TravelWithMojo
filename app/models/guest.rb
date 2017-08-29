class Guest < ApplicationRecord
	validates :first_name, :email, presence: true 

  	belongs_to :user
#	belongs_to :experience

end
