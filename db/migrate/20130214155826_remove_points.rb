class RemovePoints < ActiveRecord::Migration
  def up
    drop_table :points
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
