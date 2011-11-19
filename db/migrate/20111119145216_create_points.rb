class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :value
      t.string :reason_type
      t.integer :reason_id
      t.references :user
      t.string :note

      t.timestamps
    end
    add_index :points, :user_id
  end
end
