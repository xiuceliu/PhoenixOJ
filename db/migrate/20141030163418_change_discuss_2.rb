class ChangeDiscuss2 < ActiveRecord::Migration
  def change
  	# remove_column :discusses, :user, :string
  	change_table :discusses do |t|
      t.references :user, index: true
    end
  end
end
