class RemoveAdminsFromTournaments < ActiveRecord::Migration
  def up
    remove_column :tournaments, :admins
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
