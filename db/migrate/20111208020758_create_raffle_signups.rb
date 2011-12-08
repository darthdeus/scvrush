class CreateRaffleSignups < ActiveRecord::Migration
  def change
    create_table :raffle_signups do |t|
      t.integer :user_id
      t.integer :raffle_id

      t.timestamps
    end
  end
end
