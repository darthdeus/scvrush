class AddIdSuffixToMatchPlayers < ActiveRecord::Migration
  def change
    rename_column :matches, :player1, :player1_id
    rename_column :matches, :player2, :player2_id
  end
end
