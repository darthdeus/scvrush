class RemoveRaffleSignups < ActiveRecord::Migration
  def up
    drop_table :raffle_signups
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
