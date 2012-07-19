class AddTypeAndDescriptionToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :tournament_type, :string
    add_column :tournaments, :description, :text
    add_column :tournaments, :admins, :string
  end
end
