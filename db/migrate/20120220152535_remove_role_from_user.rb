class RemoveRoleFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :role
  end

  def down
    add_column :users, :role, :integer, :default => 0
  end
end
