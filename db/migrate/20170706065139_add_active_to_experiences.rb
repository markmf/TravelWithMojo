class AddActiveToExperiences < ActiveRecord::Migration[5.1]
  def change
    add_column :experiences, :active, :boolean
  end
end
