class AddSignupsCountToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :signups_count, :integer
  end
end
