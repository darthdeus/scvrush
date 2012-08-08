class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user,       null: false
      t.boolean :unread,        default: true
      t.text :text,             null: false
      t.references :notifiable, null: false, polymorphic: true

      t.timestamps
    end

    add_index :notifications, :user_id
    add_index :notifications, [:notifiable_id, :notifiable_type]
  end
end
