class RemoveRaffles < ActiveRecord::Migration
  def up
    drop_table :raffles
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
