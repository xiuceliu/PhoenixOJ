class AddTitleToDiscusses < ActiveRecord::Migration
  def change
  	add_column :discusses, :title, :string
  end
end
