class AddVotesCountToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :votes_count, :integer, default: 0
  end
end
