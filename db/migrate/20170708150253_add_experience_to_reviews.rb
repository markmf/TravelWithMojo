class AddExperienceToReviews < ActiveRecord::Migration[5.1]
  def change
    add_reference :reviews, :experience, foreign_key: true
  end
end
