class CreateSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :schedules do |t|
      t.references :user, foreign_key: true
      t.references :experience, foreign_key: true
      t.datetime :start_date
      t.integer :no_guests, default: 0
      t.integer :max_guests
    
      t.timestamps
    end
  end
end