class CreateCoaches < ActiveRecord::Migration
  def change
    create_table :coaches do |t|
      t.integer :order
      t.string :title
      t.integer :post_id

      t.timestamps
    end
  end
end
