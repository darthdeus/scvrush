class CreateNewStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.text    :text,        null: false
      t.integer :user_id,     null: false
      t.integer :timeline_id, null: false

      t.timestamps
    end

  end
end
