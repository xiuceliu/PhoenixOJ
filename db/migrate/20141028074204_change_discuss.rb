class ChangeDiscuss < ActiveRecord::Migration
  def change
    remove_column :discusses, :users, :string
    add_column :discusses, :user, :string
  end
end
