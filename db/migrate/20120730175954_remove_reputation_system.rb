class RemoveReputationSystem < ActiveRecord::Migration
  def up
    remove_index :rs_reputation_messages, :name => "index_rs_reputation_messages_on_receiver_id_and_sender"
    remove_index :rs_reputations, :name => "index_rs_reputations_on_reputation_name_and_target"
    drop_table :rs_evaluations
    drop_table :rs_reputations
    drop_table :rs_reputation_messages
  end

  def down
  end
end
