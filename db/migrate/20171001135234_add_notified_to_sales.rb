class AddNotifiedToSales < ActiveRecord::Migration[5.1]
  def change
    add_column :sales, :notified, :boolean, default: false
  end
end
