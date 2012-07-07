class AddTextToRound < ActiveRecord::Migration
  def change
    add_column :rounds, :text, :text
    add_column :rounds, :bo, :integer
    remove_column :matches, :bo
  end
end
