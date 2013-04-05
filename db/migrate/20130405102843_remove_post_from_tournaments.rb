class RemovePostFromTournaments < ActiveRecord::Migration

  def change
    remove_column :tournaments, :post_id
  end

end
