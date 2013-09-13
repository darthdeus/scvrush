class AlterBattleReports < ActiveRecord::Migration
  def change
    add_column :battle_reports, :vod, :string
    add_column :battle_reports, :next_tournament, :string
    add_column :battle_reports, :team_liquid, :string
  end
end
