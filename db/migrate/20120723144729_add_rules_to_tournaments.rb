class AddRulesToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :rules, :text
    add_column :tournaments, :map_info, :text
  end
end
