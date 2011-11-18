class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.text :content
      t.references :topic
      t.references :user

      t.timestamps
    end
    add_index :replies, :topic_id
    add_index :replies, :user_id
  end
end
