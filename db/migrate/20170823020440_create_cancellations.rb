class CreateCancellations < ActiveRecord::Migration[5.1]
  def change
    create_table :cancellations do |t|
      t.text :desc
      

      t.timestamps
    end
  end
end
