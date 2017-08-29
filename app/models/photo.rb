class Photo < ApplicationRecord
  belongs_to :experience


  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100#", square: "200x200>", large: "500x500>" }

#["100x100#", :png]

  validates_attachment :image,  presence: true,
#	styles: { medium: "400x400#", thumb: "200x200#" },
	content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
	message: 'Only images (eg, jpeg, gif, png) allowed.'



	
end

