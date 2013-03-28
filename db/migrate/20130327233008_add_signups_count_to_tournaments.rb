class AddSignupsCountToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :signups_count, :integer, default: 0
  end
end
