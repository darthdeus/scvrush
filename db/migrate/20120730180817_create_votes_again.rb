class CreateVotesAgain < ActiveRecord::Migration
  def up
    create_table :votes do |t|
      t.references :voteable, polymorphic: true, null: false
      t.references :user,    null: false
      t.integer    :value,   null: false

      t.timestamps
    end
  end

  def down
    drop_table :votes
  end
end
