class CreateSignups < ActiveRecord::Migration
  def change
    create_table :signups do |t|
      t.references :tournament
      t.references :user
      t.string :status
      t.integer :placement

      t.timestamps
    end
    add_index :signups, :tournament_id
    add_index :signups, :user_id
  end
end
