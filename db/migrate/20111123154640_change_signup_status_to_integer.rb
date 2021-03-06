class ChangeSignupStatusToInteger < ActiveRecord::Migration
  def up
    remove_column :signups, :status
    add_column :signups, :status, :integer, :default => 0
  end

  def down
    change_column :signups, :status, :string
  end
end
