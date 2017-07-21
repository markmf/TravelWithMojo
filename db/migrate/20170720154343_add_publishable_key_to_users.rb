class AddPublishableKeyToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :publishable_key, :string
  end
end
