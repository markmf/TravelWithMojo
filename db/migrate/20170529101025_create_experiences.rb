class CreateExperiences < ActiveRecord::Migration[5.1]
  def change
    create_table :experiences do |t|
      t.string :exp_email
      t.integer :exp_id
      t.string :exp_name
      t.text :exp_desc
      t.text :exp_provide
      t.text :exp_notes
      t.text :exp_location
      t.string :image_file_name
      t.text :about_me
      t.text :guest_reqs
      t.integer :max_guest
      t.integer :rsv_guest
      t.integer :min_guest
      t.integer :can_policy
      t.integer :ratings
      t.integer :exp_price
      t.datetime :start_time
      t.integer :duration

      t.timestamps
    end
  end
end
