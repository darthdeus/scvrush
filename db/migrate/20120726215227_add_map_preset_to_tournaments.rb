class AddMapPresetToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :map_preset, :text
  end
end
