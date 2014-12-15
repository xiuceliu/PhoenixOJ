class CreateDuties < ActiveRecord::Migration
  def up
    create_table :duties do |t|
      t.integer :message_id
      t.integer :user_id

      t.timestamps
    end
  end
  def down
    drop_table :duties
  end
end
