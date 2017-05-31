class RemoveExpIdFromExperience < ActiveRecord::Migration[5.1]
  def change
    remove_column :experiences, :exp_id, :integer
  end
end
