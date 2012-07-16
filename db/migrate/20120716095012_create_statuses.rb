class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.text :text, null: false
      t.integer :statusable_id
      t.string :statusable_type
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :statuses, :user_id
  end
end
