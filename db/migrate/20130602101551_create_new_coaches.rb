class CreateNewCoaches < ActiveRecord::Migration

  def change
    create_table :coaches, force: true do |t|
      t.string :name
      t.text :about
      t.string :races, array: true
      t.string :servers, array: true
      t.string :languages, array: true
    end
  end

end
