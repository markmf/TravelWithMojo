class AddStartDateToExperiences < ActiveRecord::Migration[5.1]
  def change
    add_column :experiences, :start_date, :date
  end
end
