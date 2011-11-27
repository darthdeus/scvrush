class AddBnetUsernameToUser < ActiveRecord::Migration
  def change
    add_column :users, :bnet_username, :string
    add_column :users, :bnet_code, :string
  end
end
