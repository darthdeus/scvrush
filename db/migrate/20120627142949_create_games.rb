class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :winner, null: false
      t.integer :match_id, null: false

      t.timestamps
    end

    add_index :games, :match_id
  end

end

