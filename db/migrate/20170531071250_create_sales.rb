class CreateSales < ActiveRecord::Migration[5.1]
  def change
    create_table :sales do |t|
      t.string :buyer_email
      t.string :seller_email
      t.integer :amount
      t.string :currency
      t.string :uuid
      t.integer :exp_id

      t.timestamps
    end
  end
end
