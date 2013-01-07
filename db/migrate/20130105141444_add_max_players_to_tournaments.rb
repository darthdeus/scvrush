class AddMaxPlayersToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :max_players, :integer
  end
end
