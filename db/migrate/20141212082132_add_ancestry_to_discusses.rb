class AddAncestryToDiscusses < ActiveRecord::Migration
  def change
  	add_column :discusses, :ancestry, :string
    add_index :discusses, :ancestry
  end
end
