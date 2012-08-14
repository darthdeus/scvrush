class AddPublicAndChannelToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :visible, :boolean
    add_column :tournaments, :channel, :string
  end
end
