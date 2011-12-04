class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string
    add_column :users, :race, :string
    add_column :users, :league, :string
    add_column :users, :server, :string
    add_column :users, :favorite_player, :string
    add_column :users, :skype, :string
    add_column :users, :msn, :string
    add_column :users, :display_email, :boolean, :default => false
    add_column :users, :display_skype, :boolean, :default => false
    add_column :users, :display_msn, :boolean, :default => false
  end
end