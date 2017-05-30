class RemoveImageFileNameFromExperiences < ActiveRecord::Migration[5.1]
  def change
    remove_column :experiences, :image_file_name, :string
  end
end
