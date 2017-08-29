class AddExperiencesToGuests < ActiveRecord::Migration[5.1]
  def change
    add_reference :guests, :experience, foreign_key: true
  end
end
