class AddLeaguesToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :leagues, :string
  end
end
