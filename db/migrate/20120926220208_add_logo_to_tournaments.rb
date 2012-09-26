class AddLogoToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :logo, :string
  end
end
