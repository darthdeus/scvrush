class AddPostToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :post_id, :integer
  end
end
