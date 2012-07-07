class AddScoreToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :score, :string
  end
end
