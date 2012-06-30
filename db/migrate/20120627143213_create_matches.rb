class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :player1
      t.integer :player2
      t.integer :bo

      t.timestamps
    end
  end

end
