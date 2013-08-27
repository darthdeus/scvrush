class AddTournamentInfoAfterBracket < ActiveRecord::Migration
  def change
    add_column :tournaments, :description_after_bracket, :text
  end
end
