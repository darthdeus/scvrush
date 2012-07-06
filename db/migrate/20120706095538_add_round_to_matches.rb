class AddRoundToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :round_id, :integer, null: false
  end
end
