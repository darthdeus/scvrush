class RemoveTimelineIdFromStatuses < ActiveRecord::Migration
  def up
    remove_column :statuses, :timeline_id
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
