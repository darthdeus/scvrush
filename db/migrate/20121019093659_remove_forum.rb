class RemoveForum < ActiveRecord::Migration
  def up
    drop_table :sections
    drop_table :topics
    drop_table :replies
  end

  def down
  end
end
