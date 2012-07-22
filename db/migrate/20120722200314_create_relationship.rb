class CreateRelationship < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
			t.references :requestor, :polymorphic => true, :null => false
			t.references :requestee, :polymorphic => true, :null => false
			t.boolean :restricted, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :relationships
  end
end
