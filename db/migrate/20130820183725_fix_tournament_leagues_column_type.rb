class FixTournamentLeaguesColumnType < ActiveRecord::Migration
  def change
    change_column :tournaments, :leagues, :string, array: true, default: []
  end
end
