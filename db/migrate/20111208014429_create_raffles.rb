class CreateRaffles < ActiveRecord::Migration
  def change
    create_table :raffles do |t|
      t.integer :status, :default => 0
      t.integer :winner_id
      t.string :title

      t.timestamps
    end
  end
end
