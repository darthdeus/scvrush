class AddSeededToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :seeded, :boolean, default: false
  end
end
