class AddArrProfailedToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :arr_profailed, :text
  end
end
