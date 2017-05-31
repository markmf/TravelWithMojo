class AddSlugToExperience < ActiveRecord::Migration[5.1]
  def change
    add_column :experiences, :slug, :string
    add_index :experiences, :slug, unique: true
  end
end
