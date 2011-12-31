class AddWinnerToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :winner_id, :integer
  end
end
