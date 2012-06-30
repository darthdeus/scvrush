class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :number, null: false
      t.integer :tournament_id, null: false
      t.integer :parent_id

    end

    add_index :rounds, :tournament_id
  end
end
