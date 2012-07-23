class AddBoPresetToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :bo_preset, :string
  end
end
