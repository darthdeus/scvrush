class RemoveUnusedFieldsFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :favorite_player
    remove_column :users, :skype
    remove_column :users, :twitter
    remove_column :users, :time_zone
    remove_column :users, :msn
    remove_column :users, :display_skype
    remove_column :users, :display_msn
    remove_column :users, :display_email
  end
end
