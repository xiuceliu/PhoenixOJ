class AddVinfoToProblems < ActiveRecord::Migration
  def change
  	add_column :problems, :ptype, :string
  	add_column :problems, :pid, :string
  end
end
