class AddLatitudeAndLongitudeToExperiences < ActiveRecord::Migration[5.1]
  def change
    add_column :experiences, :latitude, :float
    add_column :experiences, :longitude, :float
  end
end
