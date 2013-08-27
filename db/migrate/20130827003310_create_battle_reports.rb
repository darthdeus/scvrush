class CreateBattleReports < ActiveRecord::Migration
  def change
    create_table :battle_reports do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.integer :tournament_id, null: false

      t.timestamps
    end
  end
end
