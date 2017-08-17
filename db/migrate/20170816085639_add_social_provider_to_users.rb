class AddSocialProviderToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :social_provider, :string
  end
end
