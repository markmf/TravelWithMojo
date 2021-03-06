class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
     
      t.string :user_email
      t.integer :rating, default: 1
      t.text :rating_desc
      t.datetime :review_date

      t.timestamps
    end
  end
end
