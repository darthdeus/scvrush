class AddSeedToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :seed, :integer, null: false
  end
end
