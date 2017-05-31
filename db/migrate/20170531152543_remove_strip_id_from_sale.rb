class RemoveStripIdFromSale < ActiveRecord::Migration[5.1]
  def change
    remove_column :sales, :strip_id, :string
  end
end
