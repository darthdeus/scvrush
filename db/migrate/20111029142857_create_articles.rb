class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :text
      t.references :category

      t.timestamps
    end
    add_index :articles, :category_id
  end
end
