class RemoveActiveAdmin < ActiveRecord::Migration
  def up
    drop_table :active_admin_comments
  end

  def down
  end
end
