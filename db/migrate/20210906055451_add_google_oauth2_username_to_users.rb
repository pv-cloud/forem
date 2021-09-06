class AddGoogleOauth2UsernameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :googleoauth2_username, :string
  end
end
