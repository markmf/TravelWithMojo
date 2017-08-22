class AddBookedQtyToSales < ActiveRecord::Migration[5.1]
  def change
    add_column :sales, :booked_qty, :integer
  end
end
