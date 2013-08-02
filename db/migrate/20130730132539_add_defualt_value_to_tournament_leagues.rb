class AddDefualtValueToTournamentLeagues < ActiveRecord::Migration
  def up
    remove_column :tournaments, :leagues
    add_column :tournaments, :leagues, :string, array: true, default: []
  end

  def down
  end
end
