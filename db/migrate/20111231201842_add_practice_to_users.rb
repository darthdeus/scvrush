class AddPracticeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :practice, :boolean
  end
end
