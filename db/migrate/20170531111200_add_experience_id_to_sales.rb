class AddExperienceIdToSales < ActiveRecord::Migration[5.1]
  def change
    add_column :sales, :experience_id, :integer
  end
end
