class CreateMessages < ActiveRecord::Migration
  def up
    create_table :messages do |t|
      t.integer :sender_ID
      t.integer :receiver_ID
      t.string  :receive_name
      t.boolean :state
      t.boolean :sender_delete
      t.boolean :receiver_delete
      t.string  :subject
      t.text    :content
      t.datetime  :send_time
      t.timestamps
    end
  end
  def down
    drop_table :messages
  end
end
