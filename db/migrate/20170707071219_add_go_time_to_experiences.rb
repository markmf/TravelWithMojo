class AddGoTimeToExperiences < ActiveRecord::Migration[5.1]
  def change
    add_column :experiences, :go_time, :time
  end
end
