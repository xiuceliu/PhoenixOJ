class AddArrProsolvedToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :arr_prosolved, :text
  end
end
