class RemoveGames < ActiveRecord::Migration

  def up
    drop_table :games
  end

end
