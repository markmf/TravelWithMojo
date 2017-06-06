class AddExpNameToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :exp_name, :string
  end
end
