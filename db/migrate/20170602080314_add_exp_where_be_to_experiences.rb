class AddExpWhereBeToExperiences < ActiveRecord::Migration[5.1]
  def change
    add_column :experiences, :exp_where_be, :text
  end
end
