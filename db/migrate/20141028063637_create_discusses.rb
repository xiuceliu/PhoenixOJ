class CreateDiscusses < ActiveRecord::Migration
  def change
    create_table :discusses do |t|
      # t.string :user
      t.text :content

      t.references :problem, index: true

      t.timestamps
    end
  end
end
