class AddRegionToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :region, :string
  end
end
