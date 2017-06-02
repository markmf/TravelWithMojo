class AddExpDurationToExperiences < ActiveRecord::Migration[5.1]
  def change
    add_column :experiences, :exp_duration, :time
  end
end
