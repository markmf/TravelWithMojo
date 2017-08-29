class AddStartDateToSales < ActiveRecord::Migration[5.1]
  def change
    add_column :sales, :start_date, :date
  end
end
